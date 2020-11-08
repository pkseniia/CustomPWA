//
//  GetPhotoService.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Photos
import UIKit

typealias GetPhotoServiceResult = (Result<UIImage, Error>)

protocol GetPhotoServiceProtocol {
    func set(presentationController: UIViewController, delegate: ImagePickerDelegate)
    func checkForAccess(completion: @escaping (Bool) -> Void)
    func selectPhoto()
}

protocol ImagePickerDelegate: class {
    func didSelect(result: GetPhotoServiceResult)
}

class GetPhotoService: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    enum PhotoManagerError: LocalizedError {
        
        case unknownPickerError
        
        var errorDescription: String? {
            switch self {
            case .unknownPickerError: return "Selected image is broken"
            }
        }
    }
    
    override init() {
        self.pickerController = UIImagePickerController()
        super.init()
        self.pickerController.delegate = self
        self.pickerController.mediaTypes = ["public.image"]
        
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        if let image = image {
            delegate?.didSelect(result: .success(image))
        } else {
            delegate?.didSelect(result: .failure(PhotoManagerError.unknownPickerError))
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

extension GetPhotoService: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            delegate?.didSelect(result: .failure(PhotoManagerError.unknownPickerError))
            return self.pickerController(picker, didSelect: nil)
        }
        pickerController(picker, didSelect: image)
    }
}

extension GetPhotoService: UINavigationControllerDelegate {

}

extension GetPhotoService: GetPhotoServiceProtocol {
    
    func set(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.presentationController = presentationController
        self.delegate = delegate
    }
    
    func checkForAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized, .limited: completion(true)
                default: break
                }
            }
        } else {
            switch status {
            case .authorized, .limited: completion(true)
            default: completion(false)
            }
        }
    }
    
    func selectPhoto() {
        pickerController.sourceType = .photoLibrary
        presentationController?.present(self.pickerController, animated: true)
    }
}
