//
//  CommonData.swift
//  AllinOne
//
//  Created by flash on 11/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import Foundation

class CommonData{
    static let shared = CommonData()
    var cityName:String = ""
    var lat:Double = 0.0
    var long:Double = 0.0
    var defaultLat:Double = 0.0
    var defaultLong:Double = 0.0
    var country = [Country]()
}
