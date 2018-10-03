//
//  ProfileListButton.swift
//  SnapCar-iOS
//
//  Created by Abdelrahman Eldesoky on 8/29/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import Foundation
import UIKit
class ProfileListButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentHorizontalAlignment = LanguageManager.shared.isRightToLeft ? .right : .left

    }
}
