//
//  StartViewController.swift
//  AllinOne
//
//  Created by flash on 10/13/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }
    
}
