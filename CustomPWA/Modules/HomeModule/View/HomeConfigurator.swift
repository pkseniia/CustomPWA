//
//  HomeConfigurator.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import Foundation

protocol HomeConfiguratorProtocol {
    func configure(viewController: HomeViewController,
                   coordinator: CoordinatorProtocol,
                   servicesContainer: ServicesContainerProtocol)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    func configure(viewController: HomeViewController, coordinator: CoordinatorProtocol,
                   servicesContainer: ServicesContainerProtocol) {
        let selectImageUseCase = SelectImageUseCase(photoService: PhotoService())
        let homePresenter = HomePresenter(view: viewController,
                                          coordinator: coordinator,
                                          servicesContainer: servicesContainer,
                                          selectImageUseCase: selectImageUseCase)
        viewController.presenter = homePresenter
    }
}
