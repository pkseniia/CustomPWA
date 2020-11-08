//
//  RouterProtocol.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol RouterProtocol {
    var navigation: UINavigationController { get set }
    func push(controller: UIViewController)
    func present(controller: UIViewController, transitionStyle: UIModalTransitionStyle)
    func pop()
    func popToRootViewController()
    func dismissViewController(controller: UIViewController?)
}

extension RouterProtocol {

    func push(controller: UIViewController) {
        navigation.pushViewController(controller, animated: true)
    }

    func present(controller: UIViewController, transitionStyle: UIModalTransitionStyle = .coverVertical) {
        controller.modalTransitionStyle = transitionStyle
        navigation.present(controller, animated: true)
    }

    func pop() {
        navigation.popViewController(animated: true)
    }

    func popToRootViewController() {
        navigation.popToRootViewController(animated: true)
    }

    func dismissViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) {
        let viewController = navigation.visibleViewController
        viewController?.dismiss(animated: true)
    }
}
