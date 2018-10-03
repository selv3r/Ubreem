//
//  helper+Navigations.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 5/2/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit

// this class help in navigation between views EX: from home screen to Authentication, ....
extension helper {
    
    class func goToSignIn() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let vc = UIStoryboard.storyboard(with: "Authentication").instantiateInitialViewController()
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    class func goToStoryboard(with name: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let vc = UIStoryboard.storyboard(with: name).instantiateInitialViewController()
        window.rootViewController = vc
        helper.transition(with: window)
    }
    
    
    class func transition(with window: UIWindow) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = kCATransitionFade
        window.layer.add(transition, forKey: kCATransition)
    }
    
    
}


