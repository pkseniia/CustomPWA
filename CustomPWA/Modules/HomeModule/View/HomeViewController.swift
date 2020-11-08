//
//  HomeViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol HomeViewProtocol: ViewProtocol {
    func openSettings()
}

class HomeViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var openGalleryButton: UIButton!
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.set(presentationController: self)
        setupUI()
    }
    
    // MARK: - Actions
    override func buttonAction(_ sender: UIControl) -> Bool {
        if super.buttonAction(sender) { return true }
        switch sender {
        case takePhotoButton: presenter.checkForAccess(for: .camera)
        case openGalleryButton: presenter.checkForAccess(for: .photoLibrary)
        default: return false
        }
        return true
    }
    
    // MARK: - Privates
    private func setupUI() {
        initNavigation()
        takePhotoButton.setTitle(Constants.HomeScreen.takePhoto, for: .normal)
        takePhotoButton.titleLabel?.numberOfLines = 0
        openGalleryButton.setTitle(Constants.HomeScreen.openGallery, for: .normal)
        openGalleryButton.titleLabel?.numberOfLines = 0
    }
}

extension HomeViewController: HomeViewProtocol {
    func initNavigation() {
        title = Constants.HomeScreen.home
    }
    
    func openSettings() {
        // 🐰 alert
        ensureMainThread {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
    }
}
