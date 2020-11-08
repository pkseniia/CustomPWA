//
//  CoordinatorProtocol.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import Foundation

protocol CoordinatorProtocol {
    func pushIconForAppViewController(servicesContainer: ServicesContainerProtocol, image: GetImage)
    func pop(servicesContainer: ServicesContainerProtocol)
    func popToRoot(servicesContainer: ServicesContainerProtocol)
}
