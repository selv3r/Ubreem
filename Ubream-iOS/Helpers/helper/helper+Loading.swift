//
//  helper+Loading.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 5/2/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit

extension helper {
    
    class func addLoadingImageOn(view: UIView) {
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // setypAnimation.......
        
        var arrayOfImages = [UIImage]()
        for i in 0...31 {
            if let img = UIImage(named: "\(i)") {
                arrayOfImages.append(img)
            }
        }
        // start animation loading.......
        
        imageView.animationImages = arrayOfImages
        imageView.animationDuration = 1.1
        imageView.animationRepeatCount = 0 // infinite
        imageView.startAnimating()
        
    }
    
}
