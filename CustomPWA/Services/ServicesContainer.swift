//
//  ServicesContainer.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import Foundation

protocol ServicesContainerProtocol {
    var isHostReachable: Bool { get }
    func getImageForApp(by id: String, completion: @escaping FetchImageCompletion)
}

final class ServicesContainer {
    
    private let networkService: NetworkServiceProtocol
    
    init() {
        self.networkService = NetworkService()
    }
}

extension ServicesContainer: ServicesContainerProtocol {
    
    var isHostReachable: Bool {
        return networkService.isHostReachable
    }
    
    func getImageForApp(by id: String, completion: @escaping FetchImageCompletion) {
        networkService.getImageForApp(by: id, completion: completion)
    }
}
