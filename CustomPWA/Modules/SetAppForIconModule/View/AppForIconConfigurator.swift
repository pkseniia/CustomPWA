//
//  AppForIconConfigurator.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol AppForIconConfiguratorProtocol {
    func configure(viewController: AppForIconViewController,
                   coordinator: CoordinatorProtocol,
                   servicesContainer: ServicesContainerProtocol,
                   image: UIImage)
}

class AppForIconConfigurator: AppForIconConfiguratorProtocol {
    func configure(viewController: AppForIconViewController,
                   coordinator: CoordinatorProtocol,
                   servicesContainer: ServicesContainerProtocol,
                   image: UIImage) {
        let getImageForAppUseCase = GetImageForAppUseCase(image: image)
        let appForIconPresenter = AppForIconPresenter(view: viewController,
                                          coordinator: coordinator,
                                          servicesContainer: servicesContainer,
                                          getImageForAppUseCase: getImageForAppUseCase)
        viewController.presenter = appForIconPresenter
    }
}
