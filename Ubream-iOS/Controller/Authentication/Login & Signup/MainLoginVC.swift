//
//  AuthenticationVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/17/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class MainLoginVC: RootViewController {

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTabImage: UIImageView!
    @IBOutlet weak var signUpTabImage: UIImageView!
    
    var loginContainerVC: LoginContainerVC!
    var signUpContainerVC: SignUpContainerVC!
    var loginContainerVCActive: Bool = false
    
    override func viewDidLoad() {
        SavedUser.removeUser()
        super.viewDidLoad()
        instantiateLoginVCWhenStartingApp()
        
        loginButton.setTitle("LOGIN".Localize, for: .normal)
        signUpButton.setTitle("SIGN UP".Localize, for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func setup() {
        ClearNavigationBarAppearance(titleView: nil, title: nil)
    }

    
    @IBAction func loginButtonPressed(_ sender: Any) {
//        for sView in self.containerView.subviews {
//            sView.removeFromSuperview()
//            print("It's Working!")
//        }
        
        if loginContainerVCActive == false {
            loginContainerVCActive = true
            loginContainerVC.view.frame = self.containerView.bounds
            self.containerView.addSubview(loginContainerVC.view)
            signUpButton.alpha = 0.5
            signUpTabImage.alpha = 0
            loginButton.alpha = 1
            loginTabImage.alpha = 1
            print("Transform Done")
        }
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
//        for sView in self.containerView.subviews {
//            sView.removeFromSuperview()
//            print("It's Working!")
//        }
        
        if loginContainerVCActive == true {
            loginContainerVCActive = false
            signUpContainerVC.view.frame = self.containerView.bounds
            self.containerView.addSubview(signUpContainerVC.view)
            loginButton.alpha = 0.5
            loginTabImage.alpha = 0
            signUpButton.alpha = 1
            signUpTabImage.alpha = 1
            print("Transform Done")
        }
    }
    
    func instantiateLoginVCWhenStartingApp() {
        
        signUpButton.alpha = 0.5
        signUpTabImage.alpha = 0
        loginButton.alpha = 1
        loginTabImage.alpha = 1
        
        loginContainerVC = UIStoryboard(name: authenticationSB, bundle: nil).instantiateViewController(withIdentifier: "loginContainerVC") as! LoginContainerVC
        
        signUpContainerVC = UIStoryboard(name: authenticationSB, bundle: nil).instantiateViewController(withIdentifier: "signUpContainerVC") as! SignUpContainerVC
        
        self.addChildViewController(loginContainerVC)
        self.addChildViewController(signUpContainerVC)
        
        loginContainerVC.view.frame = self.containerView.bounds
        self.containerView.addSubview(loginContainerVC.view)
        
        loginContainerVCActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
    }
}




//extension MainLoginVC: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("Wornkingisjf")
//        textField.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        textField.layer.borderColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = phoneNumberTextfield.text else { return true }
//        let newLength = text.characters.count + string.characters.count - range.length
//        return newLength <= 9 // Bool
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
//    
//    }
//}
