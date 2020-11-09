//
//  ExternalAppEntity.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

class ExternalAppEntity: Decodable {
    
    var name: AppNameEntity?
    var schema: String
    var appStoreId: String
    var image: UIImage? = nil
    
    private enum CodingKeys: String, CodingKey {
        case schema = "Scheme"
        case appStoreId = "Id"
        case name = "Name"
    }

    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.schema = try container.decode(String.self, forKey: .schema)
        self.appStoreId = try container.decode(String.self, forKey: .appStoreId)
        self.name = try? container.decodeIfPresent(AppNameEntity.self, forKey: .name)
        
    }
}
