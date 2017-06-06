//
//  TownCellTableViewCell.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 6/5/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

class TownCellTableViewCell: UITableViewCell {

    @IBOutlet weak var town: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
