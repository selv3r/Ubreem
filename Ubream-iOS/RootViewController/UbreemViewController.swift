//
//  UbreemViewController.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/19/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class UbreemViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = ColorConstant.mainColor
        self.navigationBar.tintColor = UIColor.white
        // Background and seperator
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        
        //let paragraph = NSMutableParagraphStyle()
        //paragraph.alignment = .right
        //self.navigationBar.titleTextAttributes = [NSAttributedStringKey.paragraphStyle :paragraph ,NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont(name:"NeoSansArabic" , size:24)!]
        
        if #available(iOS 11.0, *) {
//            self.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font: UIFont(name:"NeoSansArabic" , size:24)!]
        } else {
            // Fallback on earlier versions
        }
        self.view.backgroundColor = ColorConstant.blue
        self.navigationBar.backgroundColor = ColorConstant.blue
        let backImage = UIImage(named: "chevron_left - material")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-2000, 0), for: .default)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
