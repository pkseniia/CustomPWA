//
//  CreateAppModelUseCase.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol CreateAppEntityUseCaseProtocol {
}

class CreateAppEntityUseCase {
    
    let customAppEntity: CustomAppEntity
    
    init() {
        self.customAppEntity = CustomAppEntity()
    }
}

extension CreateAppEntityUseCase: CreateAppEntityUseCaseProtocol {
}
