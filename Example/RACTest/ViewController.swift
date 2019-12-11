//
//  ViewController.swift
//  RACTest
//
//  Created by xupeng on 12/10/2019.
//  Copyright (c) 2019 xupeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {

    @objc
    dynamic var point: CGPoint = CGPoint(x: 0, y: 0)

//    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupScrollView()
        UIViewController.hookMethod()
        setupAction()
        excutePointChange()
    }

//    func setupScrollView() {
//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
//
//        let contentView = UIView()
//        contentView.backgroundColor = .brown
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints { (make) in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(240)
//        }
//    }

    func setupAction() {
//        _ = scrollView.rx.observe(CGPoint.self, #keyPath(UIScrollView.contentOffset))
//            .subscribe(onNext: { (point) in
//                NSLog("name:\(self) -- \(String(describing:object_getClass(self))) -- \(NSStringFromCGPoint(point!)) -- size changed")
//            })
//        _ = scrollView.rx.methodInvoked(#selector(UIScrollView.layoutSubviews))
//            .subscribe(onNext: { (_) in
//            NSLog("name:\(self) -- \(String(describing:object_getClass(self))) -- layoutSubviews")
//        })
        _ = self.rx.observe(CGPoint.self, #keyPath(ViewController.point))
            .subscribe(onNext: { (point) in
                NSLog("name:\(self) -- \(String(describing:object_getClass(self))) -- \(NSStringFromCGPoint(point!)) -- point changed")
            })
        _ = self.rx.methodInvoked(#selector(viewDidAppear(_:)))
            .subscribe(onNext: { (_) in
                NSLog("name:\(self) -- \(String(describing:object_getClass(self))) -- methodInvoked")
            })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let testVC = TestViewController()
            self.navigationController?.pushViewController(testVC, animated: true)
        }
    }

    func excutePointChange() {
        self.point = CGPoint(x: Double((arc4random() % 100)), y: Double((arc4random() % 100)))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.excutePointChange()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

