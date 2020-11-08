//
//  CustomNavigationController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configurateUI()
    }

    func configurateUI() {
        navigationBar.barTintColor = .named(.navigationBackground)
        navigationBar.tintColor = .named(.textColor)
        let titleAttributes = Attributes.main(with: Fonts.semibold.of(size: 20),
                                              color: .named(.textColor))
        navigationBar.titleTextAttributes = titleAttributes
        navigationBar.dropShadow(color: .named(.textColor),
                                 radius: 2,
                                 shadowOffset: CGSize(width: 0.2, height: 3))
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        viewController.navigationController?.navigationBar.backIndicatorImage = .custom(name: .arrowLeft)
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = .custom(name: .arrowLeft)
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
}
