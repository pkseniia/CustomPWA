//
//  HomeCoordinator.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

class HomeCoordinator {
    private var router: RouterProtocol
    private var appCoordinator: AppCoordinator

    init(router: RouterProtocol, appCoordinator: AppCoordinator) {
        self.router = router
        self.appCoordinator = appCoordinator
    }

    private enum Path: String {
        case home = "Home"
        case appForIcon = "AppForIcon"
    }

    func initializeStartController(servicesContainer: ServicesContainerProtocol) ->
        UINavigationController {
        router.navigation.viewControllers = [
            createHomeViewController(servicesContainer: servicesContainer)
            ]
        return router.navigation
    }

    func createHomeViewController(servicesContainer: ServicesContainerProtocol) -> UIViewController {
        let viewController = HomeViewController.instantiate(storyboardName: Path.home.rawValue)
        let configurator: HomeConfiguratorProtocol = HomeConfigurator()
        configurator.configure(viewController: viewController,
                               coordinator: self,
                               servicesContainer: servicesContainer)
        return viewController
    }
    
    func pushIconForAppViewController(servicesContainer: ServicesContainerProtocol, image: GetImage) {
        let viewController = AppForIconViewController.instantiate(storyboardName: Path.appForIcon.rawValue)
        let configurator: AppForIconConfiguratorProtocol = AppForIconConfigurator()
        configurator.configure(viewController: viewController,
                               coordinator: self,
                               servicesContainer: servicesContainer,
                               image: image)
        router.push(controller: viewController)
    }
}

extension HomeCoordinator: CoordinatorProtocol {
    func pop(servicesContainer: ServicesContainerProtocol) {
        router.pop()
    }
    
    func popToRoot(servicesContainer: ServicesContainerProtocol) {
        router.popToRootViewController()
    }
}
