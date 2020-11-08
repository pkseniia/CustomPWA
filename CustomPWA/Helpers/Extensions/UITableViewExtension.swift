//
//  UITableViewExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

extension UITableView {
    func cellWith(_ object: CellObjectConfigurable, in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: object.cellClass)
        tableView.register(object.cellNib, forCellReuseIdentifier: identifier)
        if let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CellRenewable & UITableViewCell {
            cell.shouldUpdateCell(withObject: object)
            return cell
        }
        return UITableViewCell()
    }
}
