//
//  HomeTabBarVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/22/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class HomeTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMiddleButton()
        addCenterButton(withImage: #imageLiteral(resourceName: "main_button"), highlightImage: #imageLiteral(resourceName: "main_button"))
    }
    
    func setupUI() {
        tabBar.barTintColor = ColorConstant.darkBlue
//        let logo = UIImage(named: "navgiation_logo")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
//        self.navigationController?.navigationBar.barTintColor = ColorConstant.mainColor
    }
    
    func setupMiddleButton() {
//        if LanguageManager.shared.isRightToLeft {
            self.addCenterButton(withImage: UIImage(named: "main_icon")!, highlightImage: UIImage(named: "main_icon")!)
            
//        }else{
//            self.addCenterButton(withImage: UIImage(named: "main_icon")!, highlightImage: UIImage(named: "main_icon")!)
//        }
    }
    
    @objc func handleTouchTabbarCenter(sender : UIButton)
    {
        self.selectedViewController = self.viewControllers![2]
    }
    
    func addCenterButton(withImage buttonImage : UIImage, highlightImage: UIImage) {
        
        let button = UIButton()
        button.setImage(buttonImage, for: .normal)
        button.sizeThatFits(CGSize(width: buttonImage.size.width, height: buttonImage.size.height))
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = (buttonImage.size.width) / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorConstant.mainColor
        
        tabBar.addSubview(button)
        tabBar.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: button.centerYAnchor, constant: -15).isActive = true
        button.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)
    }
    
    
}
