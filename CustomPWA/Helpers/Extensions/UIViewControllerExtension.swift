//
//  UIViewControllerExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

extension UIViewController {

    /// Adds child view controller to the parent
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// It removes the child view controller from the parent
    func remove() {
        if isExistValue(parent) {
            willMove(toParent: nil)
            removeFromParent()
            view.removeFromSuperview()
        }
    }
}
