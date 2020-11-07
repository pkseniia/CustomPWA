//
//  UIImageExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

extension UIImage {

    static func custom(name: ImagesName) -> UIImage {
        return UIImage(named: name.rawValue)!
    }
}
