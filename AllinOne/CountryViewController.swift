//
//  CountryViewController.swift
//  AllinOne
//
//  Created by flash on 10/17/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var countryName = ""
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        textLabel.text = countryName
        
        for x in countries{
            print(x.name.common," : ",x.name.official)
        }
        
    }

}
