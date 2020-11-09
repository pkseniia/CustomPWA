//
//  UIApplicationExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import UIKit

extension UIApplication {

    static var applicationRoot: UIViewController? {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
    }

    class func topViewController(controller: UIViewController? = UIApplication.applicationRoot) -> UIViewController? {
        if let tabBarController = controller as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(controller: selected)
            }
        }

        if let navigationController = controller as? UINavigationController {
            if let visible = navigationController.visibleViewController {
                return topViewController(controller: visible)
            }
        }

        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }

        return controller
    }
}
