//
//  detallTableViewCell.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 1/24/18.
//  Copyright © 2018 Badoyan Arman. All rights reserved.
//

import UIKit

class detallTableViewCell: UITableViewCell {
    
    @IBOutlet var fieldLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
