//
//  AppNameEntity.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

struct AppNameEntity: Decodable {
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case en = "en"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let name = try? container.decode(String.self) {
            self.name = name
        } else {
            let newContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try newContainer.decodeIfPresent(String.self, forKey: .en)
        }
    }
}
