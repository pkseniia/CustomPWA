//
//  CreateAppModelUseCase.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol CreateAppEntityUseCaseProtocol {
    func setCustomImage(image: UIImage)
    func setName(name: String?)
    func set(originalTitle: String?, originalImage: UIImage?, schema: String)
    func checkIfEntityIsReady() -> Bool
    func getCurrentEntity() -> CustomAppEntity
}

class CreateAppEntityUseCase {
    
    let customAppEntity: CustomAppEntity
    
    init() {
        self.customAppEntity = CustomAppEntity()
    }
}

extension CreateAppEntityUseCase: CreateAppEntityUseCaseProtocol {
    
    func setCustomImage(image: UIImage) {
        customAppEntity.setCustomImage(image: image)
    }
    
    func setName(name: String?) {
        customAppEntity.setName(name: name)
    }
    
    func set(originalTitle: String?, originalImage: UIImage?, schema: String) {
        customAppEntity.set(originalTitle: originalTitle, originalImage: originalImage, schema: schema)
    }
    
    func checkIfEntityIsReady() -> Bool {
        customAppEntity.checkIfEntityIsReady()
    }
    
    func getCurrentEntity() -> CustomAppEntity {
        customAppEntity
    }
}
