//
//  StartService.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol StartServiceProtocol {
    func start()
}

final class StartService {
    
    private let coordinator: AppCoordinator
    private let servicesContainer: ServicesContainerProtocol
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        self.servicesContainer = ServicesContainer()
    }
}

extension StartService: StartServiceProtocol {
    func start() {
        coordinator.makeHomeRoot(servicesContainer: servicesContainer)
    }
}
