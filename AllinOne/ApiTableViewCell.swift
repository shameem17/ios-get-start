//
//  ApiTableViewCell.swift
//  AllinOne
//
//  Created by flash on 10/17/23.
//  Copyright © 2023 flash. All rights reserved.
//

import UIKit

class ApiTableViewCell: UITableViewCell {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var capital: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
