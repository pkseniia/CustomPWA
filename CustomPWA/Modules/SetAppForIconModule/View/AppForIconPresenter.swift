//
//  AppForIconPresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

protocol AppForIconPresenterProtocol: BasePresenterProtocol {

}

class AppForIconPresenter<View: AppForIconViewProtocol>: BasePresenter<View> {
    
    private let coordinator: CoordinatorProtocol
    private let servicesContainer: ServicesContainerProtocol
    private let getImageForAppUseCase: GetImageForAppUseCaseProtocol
    
    init(view: View,
         coordinator: CoordinatorProtocol,
         servicesContainer: ServicesContainerProtocol,
         getImageForAppUseCase: GetImageForAppUseCaseProtocol) {
        self.coordinator = coordinator
        self.servicesContainer = servicesContainer
        self.getImageForAppUseCase = getImageForAppUseCase
        super.init(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setImage(with: getImageForAppUseCase.getImage())
    }
}

extension AppForIconPresenter: AppForIconPresenterProtocol {

    
}

