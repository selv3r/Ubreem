//
//  LoginContainerVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/17/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class LoginContainerVC: RootViewController {
    
    
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var invalidPhoneNumberLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButtonX!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        phoneTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    func setupUI() {
        
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Password".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        phoneTextfield.attributedPlaceholder = NSAttributedString(string: "Phone Number".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        //Customizing Keyboard with Done Button
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexableSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([flexableSpace, doneButton], animated: true)
        
        phoneTextfield.inputAccessoryView = toolBar
        passwordTextfield.inputAccessoryView = toolBar
        
        invalidPhoneNumberLabel.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if !validation() {
            colorAlert(textfield: phoneTextfield)
            invalidPhoneNumberLabel.isHidden = false
            
        }
        
        if validation() {
            StartLoading()
            
            let phoneNumber = "966-" + phoneTextfield.text!
            //print(phoneNumber)
            
            API.shared.login(phoneNumber: phoneNumber, password: passwordTextfield.text!) { [weak self](data, success, error) in
                
                if !(NetworkManager.shared.connected) {
                    self?.DangerAlert(message: "No Internet Connection".Localize)
                }
                
                if let error = error {
                    self?.StopLoading()
                    self?.callAlert(title: "Authentication Error", message: "Phone Number or Password is wrong, Please try again.")
                }
                
                if let data = data {
                    self?.StopLoading()
                    let user = data
                    if data.type == 1 {
                        SavedUser.saveUser(user)
                    } else if data.type == 2 {
                        SavedUser.saveUser(user)
                    }
                    
                    self?.goToHome()
                    
                    self?.callAlert(title: "Login Successful", message: "Ana 3aref ana ba3mel eh ya Aya >.<")
                }
            }
            
        }
        
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        let viewController = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        viewController.screenType = .forgotPassword
        viewController.title = "Forgot Password"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
    func validation() -> Bool {
        var fields = [ValidationData]()
        
        fields.append(ValidationData(value: phoneTextfield.text! ,name : "Phone Number".Localize , type:"required|phone"))
        
        return Validation.instance.SetValidation(ValidationData: fields)
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }


}


extension LoginContainerVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Wornkingisjf")
        textField.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.borderColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextfield {
            let str = (NSString(string: textField.text!)).replacingCharacters(in: range, with: string)
            if str.characters.count <= 9 {
                return true
            }
            textField.text = str.substring(to: str.index(str.startIndex, offsetBy: 9))
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
