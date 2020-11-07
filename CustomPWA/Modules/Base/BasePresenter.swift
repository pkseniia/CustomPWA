//
//  BasePresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import Foundation

protocol BasePresenterProtocol {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

class BasePresenter<View: BaseViewProtocol>: BasePresenterProtocol {

    weak var view: View!
    
    init(view: View) {
        self.view = view
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    
    // 🐰
//    open func process(error: Error, completion: ((Bool) -> Void)? = nil) {
//        view.showAlert(title: "ALERT_TITLE_ERROR".localized(),
//                       message: error.localizedDescription,
//                       preferredStyle: .alert,
//                       cancelTitle: nil,
//                       confirmTitle: "OK_BUTTON_TITLE".localized(),
//                       confirmStyle: .default,
//                       completion: completion)
//    }
    
}
