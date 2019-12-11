//
//  UIViewController+Swizzle.swift
//  RACTest_Example
//
//  Created by xupeng on 2019/12/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIViewController {
    static func hookMethod() {
        let swizzle: ((Selector, Selector) -> Void) = { (originalSelector, targetSelector) in
            guard let originalMethod = class_getInstanceMethod(self, originalSelector),
                let targetMethod = class_getInstanceMethod(self, targetSelector) else { return }
            method_exchangeImplementations(originalMethod, targetMethod)
        }
        swizzle(#selector(self.viewDidAppear(_:)), #selector(self.hook_viewDidAppear(_:)))
    }

    @objc func hook_viewDidAppear(_ animated: Bool) {
        NSLog("name:\(self) \(NSStringFromClass(object_getClass(self) ?? UIViewController.self)) -- hook_viewDidAppear")
        hook_viewDidAppear(animated)
    }
}
