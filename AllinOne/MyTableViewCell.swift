//
//  MyTableViewCell.swift
//  AllinOne
//
//  Created by flash on 10/16/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
