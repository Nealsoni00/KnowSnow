//
//  CustomCell.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/22/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var marker: UIImageView!
 
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

