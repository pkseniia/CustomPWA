//
//  SelectImageUseCase.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

typealias ImageSelectedCompletion = (Result<UIImage, Error>) -> Void

protocol SelectImageUseCaseProtocol {
    func set(presentationController: UIViewController)
    func checkForAccess(for type: PhotoServiceType, completion: @escaping () -> Void)
    func updateImage(completion: @escaping ImageSelectedCompletion)
}

class SelectImageUseCase {
    
    let photoService: PhotoServiceProtocol
    var newPhotoSelected: ImageSelectedCompletion?
    
    var newPhoto: UIImage = UIImage() {
        didSet {
            newPhotoSelected?(.success(newPhoto))
        }
    }
    
    init(photoService: PhotoServiceProtocol) {
        self.photoService = photoService
    }
}

extension SelectImageUseCase: SelectImageUseCaseProtocol {
    
    func set(presentationController: UIViewController) {
        photoService.set(presentationController: presentationController, delegate: self)
    }
    
    func checkForAccess(for type: PhotoServiceType, completion: @escaping () -> Void) {
        photoService.checkForAccess(for: type, completion: completion)
    }
    
    func updateImage(completion: @escaping ImageSelectedCompletion) {
        newPhotoSelected = completion
    }
}

extension SelectImageUseCase: ImagePickerDelegate {
    func didSelect(result: GetPhotoServiceResult) {
        switch result {
        case .success(let image): newPhoto = image
        case .failure(let error): newPhotoSelected?(.failure(error))
        }
    }
}
