//
//  AmanTabBarController.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 5/7/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit

//enum UserType {
//
//    case user, showroom
//
//    var storyboardTitle: String {
//        switch self {
//        case .user:
//            return "UserProfile"
//        case .showroom:
//            return "ShowRoomProfile"
//        }
//    }
//
//}

class HomeTabBarController: UITabBarController {
    
    var menuButton = UIButton(frame: CGRect(x: 0, y:0, width: 54, height: 54))
    var moreButton = UIButton(frame: CGRect(x: 0, y:0, width: 64, height: 64))
    //    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    var selected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.selectedViewController = self.viewControllers![2]

    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Check for Surveys and Display them.
    }

    func setup() {
//        setupAccountStoryboard()
//        setupTitles()
//        setupAppearance()
        //        setupMoreButton()
        setupMiddleButton()
        notLogin()
        
        self.tabBar.items![0].selectedImage = #imageLiteral(resourceName: "chat_bubble_active")
        self.tabBar.items![1].selectedImage = #imageLiteral(resourceName: "favorite_active")
        self.tabBar.items![3].selectedImage = #imageLiteral(resourceName: "notifications_active")
        
        for item in self.tabBar.items!{
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    
    @objc func openNotificationController(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let data = userInfo["data"] as? Bool, data == true {
                self.selectedViewController = self.viewControllers![3]
            }
        }
    }
    func notLogin() {
//        if let _ = User.read(managedContext: CoreDataStack.shared.mainContext) {
//            tabBar.items![0].isEnabled = true
//            tabBar.items![3].isEnabled = true
//        }
//        else {
//            tabBar.items![0].isEnabled = false
//            tabBar.items![3].isEnabled = false
//
//        }
    }
    
    func setupTitles() {
        self.tabBar.items?[0].title = "Chat".locale
        self.tabBar.items?[1].title = "Favorite".locale
        self.tabBar.items?[3].title = "Notifications".locale
        self.tabBar.items?[4].title = "Account".locale
    }
    
    func setupAppearance() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12), NSAttributedStringKey.backgroundColor: ColorConstant.blue], for: .normal)
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    func setupMoreButton() {
        var moreButtonFrame: CGRect!
        if UIDevice.isIphoneX
        {
            // is iPhoneX
            moreButtonFrame = CGRect(x: 0, y:0, width: view.frame.width / 4 , height: 44)
            moreButtonFrame.origin.y = view.frame.height - (moreButtonFrame.height + 40)
        }
        else
        {
            // is not iPhoneX
            moreButtonFrame = CGRect(x: 0, y:0, width: view.frame.width / 4 , height: 64)
            moreButtonFrame.origin.y = view.frame.height - moreButtonFrame.height + 2
        }
        
        moreButtonFrame.origin.x = LanguageManager.shared.currentLanguage == .en ? view.frame.width - moreButtonFrame.size.width + 10 :  -10
        moreButton.frame = moreButtonFrame
        moreButton.backgroundColor = .clear
        view.addSubview(moreButton)
        //        moreButton.setImage(#imageLiteral(resourceName: "main_menu_more_icon_off"), for: .normal)
        moreButton.tintColor = .lightGray
        view.layoutIfNeeded()
    }
    
    @objc private func setupAccountStoryboard() {
        // present side menu button
        
//        if let type = User.read(managedContext: CoreDataStack.shared.mainContext)?.type {
//            setupDefaultAccount(type: type)
//        }
//        else {
//            setupDefaultAccount(type: 1)
//        }
    
    }
    
//    func setupDefaultAccount(type: Int32) {
//         var storyName: String?
//        //let userType: UserType = type == 1 ? .user : .showroom
////        switch userType {
////        case .user:
////            storyName = userType.storyboardTitle
////        case .showroom:
////            storyName = userType.storyboardTitle
////        }
//        if let storyName = storyName, let controller = UIStoryboard.storyboard(with: storyName).instantiateInitialViewController() {
//            viewControllers?.append(controller)
//            self.tabBar.items?[4].image = #imageLiteral(resourceName: "person - material")
//            self.tabBar.items![4].selectedImage = #imageLiteral(resourceName: "person_active")
//            //            self.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "person_active")
//            self.tabBar.items?[4].title = "Account".locale
//            //            self.present(controller, animated: true, completion: nil)
//        }
//    }
    
    
    func setupMiddleButton() {
        if LanguageManager.shared.isRightToLeft {
            self.addCenterButton(withImage: #imageLiteral(resourceName: "home_ar"), highlightImage: #imageLiteral(resourceName: "home_ar"))

        }else{
            self.addCenterButton(withImage: #imageLiteral(resourceName: "home_active"), highlightImage: #imageLiteral(resourceName: "home_active"))
        }
    }
    
    @objc func handleTouchTabbarCenter(sender : UIButton)
    {
        self.selectedViewController = self.viewControllers![2]
    }
    
    func addCenterButton(withImage buttonImage : UIImage, highlightImage: UIImage) {
        
        let button = UIButton()
        button.setImage(buttonImage, for: .normal)
        button.sizeThatFits(CGSize(width: buttonImage.size.width + 50, height: buttonImage.size.height + 0))
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = (buttonImage.size.width) / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.addSubview(button)
        tabBar.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: button.centerYAnchor, constant: -15).isActive = true
        button.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)
    }
}
