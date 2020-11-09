//
//  AppsListConfigurator.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol AppsListConfiguratorProtocol {
    func configure(viewController: AppsListViewController,
                   coordinator: CoordinatorProtocol,
                   servicesContainer: ServicesContainerProtocol,
                   selectCallBack: @escaping SelectAppCallBack)
}

class AppsListConfigurator: AppsListConfiguratorProtocol {
    func configure(viewController: AppsListViewController,
                   coordinator: CoordinatorProtocol,
                   servicesContainer: ServicesContainerProtocol,
                   selectCallBack: @escaping SelectAppCallBack) {
        let appListPresenter = AppsListPresenter(view: viewController,
                                          coordinator: coordinator,
                                          servicesContainer: servicesContainer,
                                          selectCallBack: selectCallBack)
        viewController.presenter = appListPresenter
    }
}
