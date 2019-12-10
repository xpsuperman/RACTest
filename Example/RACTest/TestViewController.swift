//
//  TestViewController.swift
//  RACTest_Example
//
//  Created by xupeng on 2019/12/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

