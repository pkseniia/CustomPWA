//
//  AppIconTableViewCellObject.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

struct AppIconTableViewCellObject: IconForAppCellObjectProtocol {

    var cellTitle: String
    var cellImage: UIImage?
    var arrowImageHidden: Bool = false
    var textFieldAction: TextFieldCallback? = nil
}

extension AppIconTableViewCellObject: CellObjectConfigurable {
    var cellClass: AnyClass {
        return AppIconTableViewCell.self
    }

    var cellNib: UINib {
        return UINib(nibName: AppIconTableViewCell.className, bundle: nil)
    }
}
