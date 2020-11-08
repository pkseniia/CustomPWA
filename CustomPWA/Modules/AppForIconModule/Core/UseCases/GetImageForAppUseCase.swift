//
//  GetImageForAppUseCase.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

typealias GetImage = (UIImage)

protocol GetImageForAppUseCaseProtocol {
    func getImage() -> GetImage
}

class GetImageForAppUseCase {
    
    let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}

extension GetImageForAppUseCase: GetImageForAppUseCaseProtocol {
    func getImage() -> GetImage {
        image
    }
}
