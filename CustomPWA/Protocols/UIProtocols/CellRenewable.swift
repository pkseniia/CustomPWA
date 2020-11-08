//
//  CellRenewable.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

protocol CellRenewable: AnyObject {
    func shouldUpdateCell(withObject object: CellObjectConfigurable)
}
