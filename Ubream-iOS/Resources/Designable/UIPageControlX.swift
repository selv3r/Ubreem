//
//  UIPageControlX.swift
//  SnapCar-iOS
//
//  Created by Mina Shehata on 8/4/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import UIKit

class UIPageControlX: UIPageControl {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = BorderColor.cgColor
        }
    }

}
