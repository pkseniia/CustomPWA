//
//  HomeRouter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

class HomeRouter: RouterProtocol {
    
    var navigation: UINavigationController

    init() {
        navigation = CustomNavigationController()
    }
}
