//
//  ImageViewController.swift
//  AllinOne
//
//  Created by flash on 10/10/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var img:UIImage = UIImage(named: "MyImageSet") ?? UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.image = img
    }
    
    
    
    
}
