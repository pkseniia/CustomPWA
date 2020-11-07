//
//  StringAttributes.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

struct Attributes {

    static func main(with font: UIFont? = nil, color: UIColor) -> [NSAttributedString.Key: Any] {
        let attributes: [NSAttributedString.Key: Any]
        if let font = font {
            attributes = [
                .font: font,
                .foregroundColor: color
            ]
        } else {
            attributes = [.foregroundColor: color]
        }
        return attributes
    }
}
