//
//  OrdersVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/21/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class OrdersVC: UIViewController {
    @IBOutlet weak var driverAvalaibleOrderView: UIView!
    @IBOutlet weak var driverAvalaibleToOrderViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tab1Button: UIButton!
    @IBOutlet weak var tab2Button: UIButton!
    @IBOutlet weak var tab3Button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    //Check User Type Here..
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        print(SavedUser.loadUser()?.type)
        if type == 1 {
            driverAvalaibleToOrderViewHeight.constant = 0.0
            driverAvalaibleOrderView.isHidden = true
        }
        
        let logo = UIImage(named: "navgiation_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = ColorConstant.mainColor
    }


}
