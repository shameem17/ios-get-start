//
//  Weather.swift
//  AllinOne
//
//  Created by flash on 11/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import Foundation
struct Location: Decodable {
    var name: String
    var localtime: String
}
struct Condition: Decodable{
    var text: String
    var icon: String
}

struct Current: Decodable {
    var temp_c: Float
    var temp_f: Float
    var is_day: Int
    var condition: Condition
}

struct Weather: Decodable {
    var current: Current
    var location: Location
}
