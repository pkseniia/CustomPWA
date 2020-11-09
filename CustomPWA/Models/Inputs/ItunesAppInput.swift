//
//  ItunesAppInput.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import Foundation

struct ItunesAppInput: Codable {

    var entity: String = "software"
    var limit: String = "1"
    var id: String

    enum CodingKeys: String, CodingKey {
        case entity
        case limit
        case id = "term"
    }

    init(id: String) {
        self.id = id
    }
}

extension ItunesAppInput {
    var queryItems: [URLQueryItem] {
        [.init(name: "entity", value: entity),
         .init(name: "limit", value: limit),
         .init(name: "term", value: id)]
    }
}
