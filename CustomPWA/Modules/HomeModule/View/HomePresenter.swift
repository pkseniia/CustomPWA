//
//  HomePresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import UIKit

protocol HomePresenterProtocol: BasePresenterProtocol {
    func set(presentationController: UIViewController)
    func checkForAccess(for type: PhotoServiceType)
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
                self.coordinator.pushIconForAppViewController(servicesContainer: self.servicesContainer, image: image)
            case .failure(let error):
                self.view.processError(message: error.localizedDescription, completion: nil)
            }
        }
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func set(presentationController: UIViewController) {
        selectImageUseCase.set(presentationController: presentationController)
    }
    
    func checkForAccess(for type: PhotoServiceType) {
        selectImageUseCase.checkForAccess(for: type, completion: { [weak self] in
            guard let self = self else { return }
            self.view.processError(message: Constants.Errors.giveAccessPlease, completion: { success in
                if success {
                    self.view.openSettings()
                }
            })
        })
    }    
}
