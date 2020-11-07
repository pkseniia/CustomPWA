//
//  AppCoordinator.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

final class AppCoordinator {

    var window: UIWindow!
    var rootViewController: RootViewController!
    
    private enum Path: String {
        case root = "Root"
    }

    init() {}

    private func setupWindow() {
        window = nil
        rootViewController = nil
        window = UIWindow(frame: UIScreen.main.bounds)
        rootViewController = RootViewController.instantiate(storyboardName: Path.root.rawValue)
        window?.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    // MARK: - Home Router as root
    /// Show home screen from Home router
    func makeHomeRoot(servicesContainer: ServicesContainerProtocol) {
        setupWindow()
        let router = HomeRouter()
        let coordinator = HomeCoordinator(router: router, appCoordinator: self)
        let navigationController = coordinator.initializeStartController(servicesContainer: servicesContainer)
        rootViewController.add(navigationController)
    }

    // MARK: - Custom rootviewController change animation
    private func transition(to viewController: UIViewController) {
        let presenterViewController = rootViewController.children.first!
        rootViewController.transition(from: presenterViewController, to: viewController)
    }
}
