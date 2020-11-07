//
//  RootViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

// MARK: - Root container
/// Put this screen as root always, it helps to avoid memory clogging
class RootViewController: BaseViewController {

    func transition(from controller: UIViewController, to anotherController: UIViewController) {
        controller.willMove(toParent: nil)
        self.addChild(anotherController)

        self.transition(from: controller, to: anotherController, duration: self.transitionCoordinator?.transitionDuration ?? 0.4,
                        options: [], animations: nil, completion: { _ in
            controller.removeFromParent()
            controller.children.forEach({ $0.remove() })
            anotherController.didMove(toParent: self)
        })
    }
}
