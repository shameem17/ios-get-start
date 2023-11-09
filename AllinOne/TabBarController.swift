//
//  TabBarController.swift
//  AllinOne
//
//  Created by flash on 10/31/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class CommonData{
    static let shared = CommonData()
    var cityName:String = ""
    var lat:Double = 0.0
    var long:Double = 0.0
    var defaultLat:Double = 0.0
    var defaultLong:Double = 0.0
    var country = [Country]()
}

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        TabBarController.a
        // Do any additional setup after loading the view.
        
    }
    
    

    
}
