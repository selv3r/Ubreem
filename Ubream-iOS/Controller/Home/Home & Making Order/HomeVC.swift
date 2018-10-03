//
//  HomeVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/22/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noOrdersLabel: UILabel!
    @IBOutlet weak var addOrderLabel: UILabel!
    @IBOutlet weak var addOrderButton: UIButton!
    
    @IBAction func prepareForCancelation(segue: UIStoryboardSegue) {}
    
    //Check User Type Here..
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("API TOKEN \(SavedUser.loadUser()?.apiToken)")
        print("ACTIVATION \(SavedUser.loadUser()?.activation)")
        
    }
    
    func setupUI() {
        let logo = UIImage(named: "navgiation_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = ColorConstant.mainColor
    }
    
    
    @IBAction func addOrderButtonPressed(_ sender: Any) {
        let shippingLocationVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ShippingLocationVC") as! ShippingLocationVC
        self.navigationController?.pushViewController(shippingLocationVC, animated: true)
    }
    

}
