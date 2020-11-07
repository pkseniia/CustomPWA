//
//  HomePresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol HomePresenterProtocol: BasePresenterProtocol {
    
}

class HomePresenter<View: HomeViewProtocol>: BasePresenter<View> {
    
    private let coordinator: CoordinatorProtocol
    private let servicesContainer: ServicesContainerProtocol
    
    init(view: View,
         coordinator: CoordinatorProtocol,
         servicesContainer: ServicesContainerProtocol) {
        self.coordinator = coordinator
        self.servicesContainer = servicesContainer
        super.init(view: view)
    }
}

extension HomePresenter: HomePresenterProtocol {
}
