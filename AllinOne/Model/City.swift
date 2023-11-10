//
//  City.swift
//  AllinOne
//
//  Created by flash on 11/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import Foundation
struct City: Codable {
    var name: String
    var state_or_region: String
    var latitude: Double
    var longitude: Double
}
extension City {
    init(from dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? ""
        state_or_region = dictionary["state_or_region"] as? String ?? ""
        latitude = dictionary["latitude"] as? Double ?? 0.0
        longitude = dictionary["longitude"] as? Double ?? 0.0
        
    }
}
extension City {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(state_or_region, forKey: .state_or_region)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}
