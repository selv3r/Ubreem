//
//  ProfileVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/22/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Cosmos

class ProfileVC: RootViewController {

    @IBOutlet weak var userProfileImage: CircleImage!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userRating: CosmosView!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var phoneMailSeperator: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "My Profile"
    }
    
    func setupUI() {
        let user = SavedUser.loadUser()
        //User Image
        //User Rating
        
       // let fullname = (user?.firstname!)! + " " + (user?.lastname!)!
        //username.text = fullname ?? ""
        
//        userAddress.text = "\(user?.countryId) - \(user?.cityId)" ?? ""
//        userPhone.text = "\((user?.phone)!)"
//        if user?.email == nil || user?.email == "" {
//            phoneMailSeperator.isHidden = true
//            userEmail.isHidden = true
//        } else {
//            phoneMailSeperator.isHidden = false
//            userEmail.text = user?.email
//        }
        
    }
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
    }
    
    
    
    @IBAction func bankAccountButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func notificationSettingsButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        logout()
    }
    
    func logout() {
        if let top = UIApplication.topViewController() as? ProfileVC {
            SavedUser.removeUser()
            top.goToLogin()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
