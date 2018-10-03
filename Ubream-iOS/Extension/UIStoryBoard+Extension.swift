//
//  UIStoryBoard+Extension.swift
//  Re7la
//
//  Created by Mina Gad on 3/3/18.
//  Copyright © 2018 Mina Gad. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func storyboard(with name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
