//
//  DropDwonCountryViewController.swift
//  AllinOne
//
//  Created by flash on 10/18/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit
import DropDown

class DropDwonCountryViewController: UIViewController {

    @IBOutlet weak var countryLabel: UITableViewCell!
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var myButton: UIButton!
    
    
    let myDropDown = DropDown()
    let country = ["a","b","d"]
    
    @IBAction func tappedButton(_ sender: Any) {
        myDropDown.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myDropDown.anchorView = myView
        myDropDown.dataSource = country
               
               myDropDown.bottomOffset = CGPoint(x:0, y:(myDropDown.anchorView?.plainView.bounds.height)!)
               
               myDropDown.topOffset = CGPoint(x:0, y:-(myDropDown.anchorView?.plainView.bounds.height)!)
               
               myDropDown.direction = .bottom
               
               myDropDown.selectionAction = {  (index: Int, item: String) in
                self.countryLabel.textLabel?.text = self.country[index]
                   
                self.countryLabel.textLabel?.textColor = .black
                   
               }
    }
    

   

}
