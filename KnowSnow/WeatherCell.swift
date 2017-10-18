//
//  weatherCell.swift
//  KnowSnow
//
//  Created by Neal Soni on 10/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    
    @IBOutlet weak var dayOfWeek: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init—>Not being called???\n")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
