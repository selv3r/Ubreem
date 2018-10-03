//
//  UserType.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

protocol addUserType {
    func showUserType(label: String, Index: Int)
}

class UserType: UIView {

    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var customerCheckImage: UIImageView!
    @IBOutlet weak var driverCheckImage: UIImageView!
    
    var protocolType: addUserType?
    var popover: Popover?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customerLabel.text = "Customer".Localize
        driverLabel.text = "Driver".Localize
        customerCheckImage.alpha = 0
        driverCheckImage.alpha = 0
    }
    
    @IBAction func customerButtonPressed(_ sender: Any) {
        protocolType?.showUserType(label: customerLabel.text ?? "", Index: 1)
        if self.driverCheckImage.alpha == 1 {
            self.driverCheckImage.alpha = 0
        }
        self.customerCheckImage.alpha = 1
        
        popover?.dismiss()
    }
    
    
    @IBAction func driverButtonPressed(_ sender: Any) {
        protocolType?.showUserType(label: driverLabel.text ?? "", Index: 2)
        if self.customerCheckImage.alpha == 1 {
            self.customerCheckImage.alpha = 0
        }
        self.driverCheckImage.alpha = 1
        
        popover?.dismiss()
    }
    
    
    
}
