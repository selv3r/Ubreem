//
//  UITableView.swift
//  Al-Mahata
//
//  Created by abdelrahman on 6/8/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UITableView {
    @IBInspectable var backgroundImage: UIImage? {
        set {
            backgroundView = UIImageView(image: newValue)
        }
        get {
            return nil
        }
    }
    
    func reloadDataAnimatedKeepingOffset()
    {
        let offset = contentOffset
        UIView.setAnimationsEnabled(false)
        beginUpdates()
        endUpdates()
        UIView.setAnimationsEnabled(true)
        layoutIfNeeded()
        contentOffset = offset
    }
    
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - frame.size.height
        setContentOffset(CGPoint(x: 0, y: (y<0) ? 0 : y), animated: animated)
    }
}
//self.tableView.backgroundView = UIImageView(image:#imageLiteral(resourceName: "top-backgrount-purple"))
