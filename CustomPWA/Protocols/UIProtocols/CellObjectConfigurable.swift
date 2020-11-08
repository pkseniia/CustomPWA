//
//  CellObjectConfigurable.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol CellObjectConfigurable {
    var cellClass: AnyClass { get }
    var cellNib: UINib { get }
}
