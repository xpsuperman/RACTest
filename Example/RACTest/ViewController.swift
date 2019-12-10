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

class ViewController: UIViewController {

    @objc
    var point: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        UIViewController.hookMethod()
        setupAction()
        excutePointChange()
    }

    func setupAction() {
        _ = self.rx.methodInvoked(#selector(viewDidAppear(_:)))
            .subscribe(onNext: { (_) in
                NSLog("\(NSStringFromClass(object_getClass(self) ?? ViewController.self)) -- methodInvoked")
            })
        _ = self.rx.observe(CGPoint.self, "point")
            .subscribe(onNext: { (point) in
                NSLog("\(NSStringFromClass(object_getClass(self) ?? ViewController.self)) -- \(NSStringFromCGPoint(point!)) -- point changed")
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

