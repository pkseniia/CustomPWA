//
//  IconForAppCellObjectProtocol.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

typealias TextFieldCallback = (String?) -> Void

protocol IconForAppCellObjectProtocol {
    var cellTitle: String { get set }
    var cellImage: UIImage? { get set }
    var textFieldAction: TextFieldCallback? { get set }
}
