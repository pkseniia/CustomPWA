//
//  UIViewExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

extension UIView {
    
    /// Drop shadow on view with radius and offset
    func dropShadow(color: UIColor, radius: CGFloat, shadowOffset: CGSize) {
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowRadius = radius
            self.layer.shadowOpacity = 0.1
            self.layer.masksToBounds = false
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
