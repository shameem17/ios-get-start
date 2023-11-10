//
//  StartingViewController.swift
//  AllinOne
//
//  Created by flash on 10/31/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {
    var country = [Country]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        newJson()
        let indicatorView = activityIndicator(style: .large,
                                              center: self.view.center)
        
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }
    

    
}
