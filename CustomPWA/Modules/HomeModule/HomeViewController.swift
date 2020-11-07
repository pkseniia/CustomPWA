//
//  HomeViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol HomeViewProtocol: BaseViewProtocol, NavigationInitProtocol {
    
}

class HomeViewController: BaseViewController {

    // MARK: - Outlets

    // MARK: - Properties
    var presenter: HomePresenterProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    override func buttonAction(_ sender: UIControl) -> Bool {
        if super.buttonAction(sender) { return true }
//        switch sender {
//        case closeButton: presenter.close()
//        default:          return false
//        }
        return true
    }
    
    // MARK: - Privates
    private func setupUI() {
        initNavigation()
    }
}

extension HomeViewController: HomeViewProtocol {
    func initNavigation() {
        title = Constants.HomeScreen.home
    }
}
