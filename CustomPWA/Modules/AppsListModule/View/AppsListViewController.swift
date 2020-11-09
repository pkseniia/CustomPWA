//
//  AppsListViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol AppsListViewProtocol: ViewProtocol {
    func reloadTableView()
    func processError(message: String, completion: ((Bool) -> Void)?)
}

class AppsListViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var presenter: AppsListPresenterProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Privates
    private func setupUI() {
        initNavigation()
    }
}

extension AppsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.1
    }
}

extension AppsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellObject = presenter.getObject(indexPath.row) {
        let cell = tableView.cellWith(cellObject, in: tableView, at: indexPath)
        return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectItem(indexPath.row)
    }
}


extension AppsListViewController: AppsListViewProtocol {
    
    func initNavigation() {
        title = Constants.AppsList.appsList
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func processError(message: String, completion: ((Bool) -> Void)?) {
        showAlert(title: Constants.Errors.error,
                  message: message,
                  preferredStyle: .alert,
                  cancelTitle: Constants.Buttons.cancel,
                  confirmTitle: Constants.Buttons.ok,
                  confirmStyle: .default,
                  completion: completion)
    }
}
