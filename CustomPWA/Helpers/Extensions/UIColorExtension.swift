//
//  UIColorExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

enum ColorName: String, CaseIterable {
    case background
    case navigationBackground
    case textColor
}

extension UIColor {

    static func named(_ name: ColorName) -> UIColor {
        return UIColor(named: name.rawValue, in: Bundle(for: AppDelegate.self), compatibleWith: nil)!
    }
}
    
extension CGColor {
    
    static func named(_ name: ColorName) -> CGColor {
        return UIColor.named(name).cgColor
    }
}
