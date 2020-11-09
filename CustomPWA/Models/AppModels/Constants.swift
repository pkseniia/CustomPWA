//
//  Constants.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import Foundation

struct Constants {
    
    // MARK: - Localizable strings' keys
    struct HomeScreen {
        static let home = "HOME_NAVIGATION_TITLE".localized
        static let takePhoto = "HOME_TAKE_PHOTO_BUTTON_TITLE".localized
        static let openGallery = "HOME_OPEN_GALLERY_BUTTON_TITLE".localized
    }
    
    struct AppForIcon {
        static let customApp = "APP_FOR_ICON_NAVIGATION_TITLE".localized
        static let chooseApplication = "APP_FOR_ICON_CHOOSE_APPLICATION_TITLE".localized
        static let enterNameForApp = "APP_FOR_ICON_ENTER_APPLICATION_NAME_TITLE".localized
        static let createApp = "APP_FOR_ICON_CREATE_APP_BUTTON_TITLE".localized
    }
    
    struct AppsList {
        static let appsList = "APPS_LIST_NAVIGATION_TITLE".localized
    }
    
    struct Errors {
        static let imageIsBroken = "ERRORS_IMAGE_IS_BROKEN".localized
        static let error = "ERRORS_ERROR_TITLE".localized
        static let giveAccessPlease = "ERRORS_TURN_ON_THE_ACCESS_PLEASE".localized
        static let noInternetConnection = "ERRORS_NO_INTERNET".localized
    }
    
    struct Buttons {
        static let cancel = "BUTTONS_CANCEL_BUTTON_TITLE".localized
        static let ok = "BUTTONS_OK_BUTTON_TITLE".localized
        static let done = "BUTTONS_DONE_BUTTON_TITLE".localized
    }
    
    // MARK: - Strings without localization
    struct BaseUrls {
        static let itunes = "itunes.apple.com"
    }
}
