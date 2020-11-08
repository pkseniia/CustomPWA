//
//  NSObjectExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
