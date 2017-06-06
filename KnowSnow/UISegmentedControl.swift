//
//  UISegmentedControl.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/24/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

@IBDesignable class MySegmentedControl: UISegmentedControl {
    
    @IBInspectable var height: CGFloat = 200 {
        didSet {
            let centerSave = center
            frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: height)
            center = centerSave
        }
    }
}
