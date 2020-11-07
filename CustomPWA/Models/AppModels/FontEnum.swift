//
//  FontEnum.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

enum Fonts: String {
    case regular = "ProximaNova-Regular"
    case semibold = "ProximaNova-Semibold"
    case light = "ProximaNova-Light"

    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
