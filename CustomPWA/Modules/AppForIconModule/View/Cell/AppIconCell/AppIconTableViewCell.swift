//
//  AppIconTableViewCell.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

class AppIconTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
}

extension AppIconTableViewCell: CellRenewable {

    func shouldUpdateCell(withObject object: CellObjectConfigurable) {
        guard let cellObject = object as? AppIconTableViewCellObject else { return }
        iconImage.image = cellObject.cellImage
        titleLabel.text = cellObject.cellTitle
        arrowImage.isHidden = cellObject.arrowImageHidden
    }
}
