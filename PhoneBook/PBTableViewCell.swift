//
//  PBTableViewCell.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 3/3/17.
//  Copyright © 2017 Badoyan Arman. All rights reserved.
//

import UIKit

class PBTableViewCell: UITableViewCell {

    //@IBOutlet weak var nkar: UIImageView!
    
    @IBOutlet weak var nkar: UIImageView!
    @IBOutlet weak var NameLable: UILabel!
    
    @IBOutlet weak var NumLable: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
