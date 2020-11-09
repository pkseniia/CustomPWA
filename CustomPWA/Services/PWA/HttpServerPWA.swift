//
//  HttpServerPWA.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import Foundation
import Swifter

///
// Use Singleton for HttpServerPWA, because HttpServer has to be initialised once in app life cycle
///

class HttpServerPWA {
    
    static let shared = HttpServerPWA()
    
    var server: HttpServer = HttpServer()
    
    init() {}
    
    func getSever() -> HttpServer {
        return server
    }
}
