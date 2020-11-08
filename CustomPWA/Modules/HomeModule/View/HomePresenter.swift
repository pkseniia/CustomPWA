//
//  HomePresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol HomePresenterProtocol: BasePresenterProtocol {
    func set(presentationController: UIViewController)
    func openSearch()
    func openGallery()
}

class HomePresenter<View: HomeViewProtocol>: BasePresenter<View> {
    
    private let coordinator: CoordinatorProtocol
    private let servicesContainer: ServicesContainerProtocol
    private let selectImageUseCase: SelectImageUseCaseProtocol
    
    init(view: View,
         coordinator: CoordinatorProtocol,
         servicesContainer: ServicesContainerProtocol,
         selectImageUseCase: SelectImageUseCaseProtocol) {
        self.coordinator = coordinator
        self.servicesContainer = servicesContainer
        self.selectImageUseCase = selectImageUseCase
        super.init(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
    }
    
    private func getPhoto() {
        selectImageUseCase.updateImage { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                print("🐰")
            case .failure(let error):
//                self.process(error: error)
                print("🦊")
            }
        }
    }
    
    private func selectPhoto() {
        selectImageUseCase.selectPhoto()
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func set(presentationController: UIViewController) {
        selectImageUseCase.set(presentationController: presentationController)
    }
    
    func openGallery() {
        selectImageUseCase.checkForAccess(completion: { [weak self] success in
            guard let self = self else { return }
            ensureMainThread {
                if success {
                    self.selectPhoto()
                } else {
                    self.view.openSettings()
                }
            }
        })
    }
    
    func openSearch() {
        print("openSearch")
    }
    
}
