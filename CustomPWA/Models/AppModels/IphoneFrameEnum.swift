//
//  IphoneFrameEnum.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import UIKit

enum IphoneFrame {
    case iphone5
    case iphone6
    case iphonePlus
    case iphoneX
    case iphoneXr
    case iphoneMax
    
    var widthInPixels: Int {
        switch self {
        case .iphone5:      return 320
        case .iphone6:      return 375
        case .iphonePlus:   return 621
        case .iphoneX:      return 375
        case .iphoneXr:     return 414
        case .iphoneMax:    return 414
        }
    }
    
    var heightInPixels: Int {
        switch self {
        case .iphone5:      return 568
        case .iphone6:      return 667
        case .iphonePlus:   return 1104
        case .iphoneX:      return 812
        case .iphoneXr:     return 896
        case .iphoneMax:    return 896
        }
    }
    
    var splashImageFrame: CGFloat {
        CGFloat(widthInPixels / 3)
    }
}
