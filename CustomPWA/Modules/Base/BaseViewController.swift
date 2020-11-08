//
//  BaseViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

typealias ViewProtocol = BaseViewProtocol & NavigationInitProtocol

protocol BaseViewProtocol: AnyObject {
    
    func showAlert(title: String?,
                   message: String?,
                   preferredStyle: UIAlertController.Style,
                   cancelTitle: String?,
                   confirmTitle: String,
                   confirmStyle: UIAlertAction.Style,
                   completion: ((Bool) -> Void)?)
}

class BaseViewController: UIViewController, BaseViewProtocol, Storyboarded {
    
    @IBOutlet var buttons: [UIControl]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtons()
    }
    
    func bindButtons() {
        buttons?.forEach { $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside) }
    }
    
    @objc func buttonAction(_ sender: UIControl) -> Bool {
        return false
    }
    
    func showAlert(title: String?,
                   message: String?,
                   preferredStyle: UIAlertController.Style,
                   cancelTitle: String?,
                   confirmTitle: String,
                   confirmStyle: UIAlertAction.Style,
                   completion: ((Bool) -> Void)?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        alertController.addAction(.init(title: confirmTitle,
                                        style: confirmStyle) { _ in completion?(true) } )
        if let cancelTitle = cancelTitle {
            alertController.addAction(.init(title: cancelTitle,
                                            style: .cancel) { _ in completion?(false) } )
        }
        present(alertController, animated: true, completion: nil)
    }
        
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

