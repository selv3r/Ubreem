//
//  RootViewController.swift
//  General Project
//
//  Created by Mina Shehata Gad on 5/4/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    //MARK:- ViewControllerLifecycle.......
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeLisner()
    }

    func setup() {
        self.prepareAppFont("Avenir Next")
//        view.backgroundColor = ColorConstant.yellow
//        navigationController?.navigationBar.barTintColor = ColorConstant.blue
//        UILabel.appearance().font = UIFont(name: "NeoSansArabic", size: 15)
//        UITextField.appearance().font = UIFont(name: "NeoSansArabic", size: 15)
//        UITextView.appearance().font = UIFont.systemFont(ofSize: 15)
//        UIButton.appearance().titleLabel?.font = UIFont(name: "NeoSansArabic", size: 15)!
        
//       for family in UIFont.familyNames {
//           print("=========>>>>>>>>>>>>>>>>>>>>>>")
//            print(family)
//           for font in UIFont.fontNames(forFamilyName: family) {
//               print(font)
//           }
//          print("=========>>>>>>>>>>>>>>>>>>>>>>")
//        }
        
        /////// some setups
        setupLisner()
        setupBackButton()
        //        setupTextfieldInSearchBarAppearance()
    }
    
    //MARK:- Observers Or Lisner
    func setupLisner() {
         NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(notification:)), name: .StatusChanged, object: nil)
    }
    func removeLisner() {
        NotificationCenter.default.removeObserver(self, name: .StatusChanged, object: nil)

    }
    
    //MARK:- network lisners
    @objc func networkChanged(notification: Notification) {
        if let status = notification.userInfo!["status"] as? Bool
        {
            if status == false {
                DangerAlert("Error".Localize, message: "Network is offline".Localize)
            }
        }
    }
    
    func goToHome() {
        let vc = initVC(storyboard:"Home" , Identifier: "HomeTabBarVC")  as! HomeTabBarVC
        transition(vc)
        
    }
    
    func goToLogin() {
        let vc = initVC(storyboard:"Authentication" , Identifier: "MainLoginVC")  as! MainLoginVC
        transition(vc)
        
    }
    
    func initVC(storyboard:String , Identifier:String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Identifier)
        return controller
    }
    
    func transition(_ vc :UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        UIApplication.topViewController()?.view.window!.layer.add(transition, forKey: kCATransition)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    //MARK:- setup navigation controller if exist
    //Customize All Nav Items
    func ClearNavigationBarAppearance(titleView: UIView?, title: String?, titleColor: UIColor = .white, titleFont: UIFont = UIFont.systemFont(ofSize: 20)) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor, .font: titleFont]
        if let titleView = titleView {
            navigationItem.titleView = titleView
        }
        if let title = title {
            navigationItem.title = title
        }
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK:- NavigationController Controls
    func setupNavigationBar(barTintColor color: UIColor? = ColorConstant.blue, titleView: UIView?, title: String?, shadowImage: Bool = false, titleColor: UIColor = .white, titleFont: UIFont = UIFont.systemFont(ofSize: 20), large: Bool = false) {
        if large {
            if #available(iOS 11.0, *) {
                 navigationController?.navigationBar.prefersLargeTitles = large
                    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor, .font: titleFont]
            } else {
                // Fallback on earlier versions
            }
        }
        if shadowImage {
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor, .font: titleFont]
        navigationController?.navigationBar.barTintColor = color
        if let titleView = titleView {
            navigationItem.titleView = titleView
        }
        if let title = title {
            navigationItem.title = title
        }
    }
    
    //MARK:- left barButton item
    func addLeftBarButton(with image: UIImage?, or title: String?, and tintColor: UIColor = .darkGray) {
        navigationController?.navigationBar.tintColor = tintColor
        if let title = title {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: navigationController?.viewControllers.first, action: #selector(leftAction))
        }
        if let image = image {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: navigationController?.viewControllers.first, action: #selector(leftAction))
        }
    }
    
    @objc func leftAction() {
        
    }
    
    //MARK:- right barButton item
    func addRightBarButton(with image: UIImage?, or title: String?, and tintColor: UIColor = .white) {
        if let title = title {
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: navigationController?.viewControllers.first, action: #selector(rightAction))
        }
        if let image = image {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: navigationController?.viewControllers.first, action: #selector(rightAction))
            
        }
    }
    
    @objc func rightAction() {
        
    }

    //MARK:- setup fuctions IQKeyboard, SearchBar
    private func setupBackButton() {
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)
    }
    
//    private func setupTextfieldInSearchBarAppearance(with Color: UIColor, and textColor: UIColor) {
//        let textfieldsInSearchBars = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
//        textfieldsInSearchBars.tintColor = Color
//        textfieldsInSearchBars.backgroundColor = .white
//        textfieldsInSearchBars.textColor = textColor
//    }
    
    
}



class RootTableViewController: UITableViewController {
    
    //MARK:- ViewControllerLifecycle.......
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeLisner()
    }
    
    func setup() {
        self.prepareAppFont("Avenir Next")
        //        view.backgroundColor = ColorConstant.yellow
        //        navigationController?.navigationBar.barTintColor = ColorConstant.blue
        //        UILabel.appearance().font = UIFont(name: "NeoSansArabic", size: 15)
        //        UITextField.appearance().font = UIFont(name: "NeoSansArabic", size: 15)
//        UITextView.appearance().font = UIFont.systemFont(ofSize: 30)
        //        UIButton.appearance().titleLabel?.font = UIFont(name: "NeoSansArabic", size: 15)!
        
        //        for family in UIFont.familyNames {
        //            print("=========>>>>>>>>>>>>>>>>>>>>>>")
        //            print(family)
        //            for font in UIFont.fontNames(forFamilyName: family) {
        //               print(font)
        //           }
        //           print("=========>>>>>>>>>>>>>>>>>>>>>>")
        //        }
        
        /////// some setups
        setupLisner()
        setupBackButton()
        //        setupTextfieldInSearchBarAppearance()
    }
    
    //MARK:- Observers Or Lisner
    func setupLisner() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(notification:)), name: .StatusChanged, object: nil)
        
    }
    func removeLisner() {
        NotificationCenter.default.removeObserver(self, name: .StatusChanged, object: nil)
        
    }
    
    //MARK:- network lisners
    @objc func networkChanged(notification: Notification) {
        if let status = notification.userInfo!["status"] as? Bool
        {
            if status == false {
                DangerAlert("Error".Localize, message: "Network is offline".Localize)
            }
        }
    }
    
    //MARK:- setup navigation controller if exist
    func ClearNavigationBarAppearance(titleView: UIView?, title: String?, titleColor: UIColor = .darkGray, titleFont: UIFont = UIFont.systemFont(ofSize: 20)) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor, .font: titleFont]
        if let titleView = titleView {
            navigationItem.titleView = titleView
        }
        if let title = title {
            navigationItem.title = title
        }
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK:- NavigationController Controls
    func setupNavigationBar(titleView: UIView?, title: String?, shadowImage: Bool = false, titleColor: UIColor = .white, titleFont: UIFont = UIFont.systemFont(ofSize: 17), large: Bool = false) {
        if large {
            if #available(iOS 11.0, *) {
                navigationController?.navigationBar.prefersLargeTitles = large
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor, .font: titleFont]
            } else {
                // Fallback on earlier versions
            }
        }
        if shadowImage {
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor, .font: titleFont]
//        navigationController?.navigationBar.barTintColor = color
        if let titleView = titleView {
            navigationItem.titleView = titleView
        }
        if let title = title {
            navigationItem.title = title
        }
    }
    
    //MARK:- left barButton item
    func addLeftBarButton(with image: UIImage?, or title: String?, and tintColor: UIColor = .darkGray) {
        navigationController?.navigationBar.tintColor = tintColor
        if let title = title {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: navigationController?.viewControllers.first, action: #selector(leftAction))
        }
        if let image = image {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: navigationController?.viewControllers.first, action: #selector(leftAction))
        }
    }
    @objc func leftAction() {
        
    }
    
    //MARK:- right barButton item
    func addRightBarButton(with image: UIImage?, or title: String?, and tintColor: UIColor = .white) {
        if let title = title {
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: navigationController?.viewControllers.first, action: #selector(rightAction))
        }
        if let image = image {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: navigationController?.viewControllers.first, action: #selector(rightAction))
            
        }
    }
    
    @objc func rightAction() {
        
    }
    
    //MARK:- setup fuctions IQKeyboard, SearchBar
    private func setupBackButton() {
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)
    }
}

extension UITextField {
    private func getKeyboardLanguage() -> String? {
        return "en" // here you can choose keyboard any way you need
    }
    override open var textInputMode: UITextInputMode? {
        if let language = getKeyboardLanguage() {
            for tim in UITextInputMode.activeInputModes {
                if tim.primaryLanguage!.contains(language) {
                    return tim
                }
            }
        }
        return super.textInputMode
    }
}








