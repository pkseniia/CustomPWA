//
//  AppForIconViewController.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

protocol AppForIconViewProtocol: ViewProtocol {
    func setImage(with image: UIImage)
}

class AppForIconViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var presenter: AppForIconPresenterProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    override func buttonAction(_ sender: UIControl) -> Bool {
        if super.buttonAction(sender) { return true }
//        switch sender {
//        case cropButton: cropImage()
//        default: return false
//        }
        return true
    }
    
    // MARK: - Privates
    private func setupUI() {
        initNavigation()
        imageView.cornerRadius = imageView.frame.height / 5
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
}
