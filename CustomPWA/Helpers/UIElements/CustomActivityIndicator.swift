//
//  CustomActivityIndicator.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import UIKit

protocol Indicating {
    func startAnimating(fullScreen: Bool)
    func stopAnimating()
}

class CustomActivityIndicator: BaseView {

    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func customInit() {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        activityIndicator.center = convert(center, to: superview)
        addSubview(activityIndicator)
    }
}

extension CustomActivityIndicator: Indicating {

    func startAnimating(fullScreen: Bool = false) {
        let topViewController = fullScreen ? UIApplication.applicationRoot : UIApplication.topViewController()

        if let topView = topViewController?.view {
            ensureMainThread {
                topView.addSubview(self)
                self.activityIndicator.startAnimating()
            }
        }
    }

    func stopAnimating() {
        ensureMainThread {
            self.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
}
