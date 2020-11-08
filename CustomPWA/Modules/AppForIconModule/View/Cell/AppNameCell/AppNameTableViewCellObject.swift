//
//  AppNameTableViewCellObject.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

struct AppNameTableViewCellObject: IconForAppCellObjectProtocol {

    var cellTitle: String
    var cellImage: UIImage? = nil
    var textFieldAction: TextFieldCallback?
}

extension AppNameTableViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return AppNameTableViewCell.self
    }

    var cellNib: UINib {
        return UINib(nibName: AppNameTableViewCell.className, bundle: nil)
    }
}
