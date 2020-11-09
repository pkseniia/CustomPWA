//
//  ItunesAppEntity.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

struct ItunesAppEntityResults: Decodable {
    
    let results: [ItunesAppEntity]
}

struct ItunesAppEntity: Decodable {

    let artworkUrl60: String
}
