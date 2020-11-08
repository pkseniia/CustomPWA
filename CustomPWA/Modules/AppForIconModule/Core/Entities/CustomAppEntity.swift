//
//  CustomAppEntity.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

class CustomAppEntity {
    
    var originalTitle: String?
    var originalImage: UIImage?
    var title: String?
    var image: UIImage?
    var schema: String?
    
    init() {}
    
//    func set(originalTitle: String?, originalImage: UIImage?, schema: String) {
//        self.originalTitle = originalTitle
//        self.schema = schema
//        self.originalImage = originalImage
//    }
    
    func checkIfEntityIsReady() -> Bool {
        if let title = title, !title.isEmpty, image != nil, schema != nil {
            return true
        }
        return false
    }
}
