//
//  UIButton+Extenstion.swift
//  SnapCar-iOS
//
//  Created by Abdelrahman Eldesoky on 9/3/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
extension UIButton {

    @IBInspectable var titleInsetRightAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                titleEdgeInsets.right = newValue
                titleEdgeInsets.left = 0
            }
        }
        get {
            return titleEdgeInsets.right
        }
    }
    
    @IBInspectable var titleInsetLeftAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                titleEdgeInsets.left = newValue
                titleEdgeInsets.right = 0
            }
        }
        get {
            return titleEdgeInsets.left
        }
    }
    
    @IBInspectable var titleInsetTopAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                titleEdgeInsets.top = newValue
            }
        }
        get {
            return titleEdgeInsets.top
        }
    }
    
    @IBInspectable var titleInsetBottomAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                titleEdgeInsets.bottom = newValue
            }
        }
        get {
            return titleEdgeInsets.bottom
        }
    }
    
    @IBInspectable var imageInsetRightAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                imageEdgeInsets.right = newValue
                imageEdgeInsets.left = 0
            }
        }
        get {
            return imageEdgeInsets.right
        }
    }
    
    @IBInspectable var imageInsetLeftAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                imageEdgeInsets.left = newValue
                imageEdgeInsets.right = 0
            }
        }
        get {
            return imageEdgeInsets.left
        }
    }
    
    @IBInspectable var imageInsetTopAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                imageEdgeInsets.top = newValue
            }
        }
        get {
            return imageEdgeInsets.top
        }
    }
    
    @IBInspectable var imageInsetBottomAR: CGFloat {
        set {
            if LanguageManager.shared.isRightToLeft {
                imageEdgeInsets.bottom = newValue
            }
        }
        get {
            return imageEdgeInsets.bottom
        }
    }

}
