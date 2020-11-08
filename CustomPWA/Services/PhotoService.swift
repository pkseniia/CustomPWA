//
//  PhotoService.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Photos
import UIKit

typealias GetPhotoServiceResult = (Result<UIImage, Error>)

protocol PhotoServiceProtocol {
    func set(presentationController: UIViewController, delegate: ImagePickerDelegate)
    func checkForAccess(for type: PhotoServiceType, completion: @escaping () -> Void)
}

protocol ImagePickerDelegate: class {
    func didSelect(result: GetPhotoServiceResult)
}

enum PhotoServiceType {
    case camera
    case photoLibrary
}

class PhotoService: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    enum PhotoManagerError: LocalizedError {
        
        case unknownPickerError
        
        var errorDescription: String? {
            switch self {
            case .unknownPickerError: return Constants.Errors.imageIsBroken
            }
        }
    }
    
    override init() {
        self.pickerController = UIImagePickerController()
        super.init()
        self.pickerController.delegate = self
        self.pickerController.mediaTypes = ["public.image"]
        self.pickerController.allowsEditing = true
        
    }
    
    private func takePhotoWithCamera() {
        pickerController.sourceType = .camera
        presentationController?.present(self.pickerController, animated: true)
    }
    
    private func selectPhoto() {
        pickerController.sourceType = .photoLibrary
        presentationController?.present(self.pickerController, animated: true)
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

extension PhotoService: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            delegate?.didSelect(result: .failure(PhotoManagerError.unknownPickerError))
            return self.pickerController(picker, didSelect: nil)
        }
        pickerController(picker, didSelect: image)
    }
}

extension PhotoService: UINavigationControllerDelegate {

}

extension PhotoService: PhotoServiceProtocol {
    
    func set(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.presentationController = presentationController
        self.delegate = delegate
    }
    
    func checkForAccess(for type: PhotoServiceType, completion: @escaping () -> Void) {
        switch type {
        case .camera:
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authStatus {
            case .notDetermined, .authorized: takePhotoWithCamera()
            default: completion()
            }
        case .photoLibrary:
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { [weak self] status in
                    guard let self = self else {
                        completion()
                        return
                    }
                    switch status {
                    case .authorized, .limited: self.selectPhoto()
                    default: break
                    }
                }
            } else {
                switch status {
                case .authorized, .limited: selectPhoto()
                default: completion()
                }
            }
        }
    }
}
