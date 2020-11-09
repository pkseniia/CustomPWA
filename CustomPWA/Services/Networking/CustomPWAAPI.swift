//
//  CustomPWAAPI.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import UIKit

enum CustomPWAAPI {
    
    case itunesApp(model: ItunesAppInput)
}

extension CustomPWAAPI {
    
    var domainComponents: URLComponents {
        var components = URLComponents()
        
        switch self {
        case .itunesApp:
            components.scheme = "https"
            components.host = Constants.BaseUrls.itunes
            components.path = path
        }
        return components
    }
    
    var url: URL? {
        var components = domainComponents
        switch self {
        case .itunesApp(model: let input):
            components.queryItems = input.queryItems
        }
        return components.url
    }
    
    var path: String {
        switch self {
        case .itunesApp:
            return "/search"
        }
    }
    
    var headers: [String: String]? {
        let internalHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        return internalHeaders
    }
    
    var httpMethod: String {
        switch self {
        case .itunesApp:
            return "GET"
        }
    }
    
    var body: Data? {
        switch self {
        default: return nil
        }
    }
}

extension Encodable {
    var encoded: Data? {
        return try? JSONEncoder().encode(self)
    }
}
