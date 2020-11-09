//
//  AppForIconViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol AppForIconViewProtocol: ViewProtocol {
    func setImage(with image: UIImage)
    func reloadTableView()
    func enableCreateAppButton(with value: Bool)
    func showIndicator(value: Bool)
}

class AppForIconViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createAppButton: UIButton!
    
    // MARK: - Properties
    var presenter: AppForIconPresenterProtocol!
    var activityIndicator: CustomActivityIndicator?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    override func buttonAction(_ sender: UIControl) -> Bool {
        if super.buttonAction(sender) { return true }
        switch sender {
        case createAppButton: presenter.createApp()
        default: return false
        }
        return true
    }
    
    // MARK: - Privates
    private func setupUI() {
        initNavigation()
        imageView.cornerRadius = imageView.frame.height / 5
        hideKeyboardWhenTappedAround()
        enableCreateAppButton(with: false)
        createAppButton.setTitle(Constants.AppForIcon.createApp, for: .normal)
        activityIndicator = CustomActivityIndicator(frame: view.bounds)
    }
}

extension AppForIconViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.1
    }
}

extension AppForIconViewController: UITableViewDataSource {
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
        if indexPath.row == 0 {
            presenter.pushSelectAppScreen()
        }
    }
}


extension AppForIconViewController: AppForIconViewProtocol {
    
    func initNavigation() {
        title = Constants.AppForIcon.customApp
    }
    
    func setImage(with image: UIImage) {
        imageView.image = image
        print(image.size)
    }
    
    func enableCreateAppButton(with value: Bool) {
        createAppButton.isUserInteractionEnabled = value
        createAppButton.alpha = value ? 1 : 0.3
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showIndicator(value: Bool) {
        value ?
            activityIndicator?.startAnimating() :
            activityIndicator?.stopAnimating()
    }
}
