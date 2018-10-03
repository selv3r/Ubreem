//
//  ForgotPasswordVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/20/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

enum ScreenType {
    case forgotPassword
    case newPassword
    case changePassword
}

class ForgotPasswordVC: RootViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phonePasswordLabel: UILabel!
    @IBOutlet weak var phonePasswordTextfield: UITextFieldX!
    @IBOutlet weak var sendButton: UIButtonX!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    var screenType: ScreenType?
    var code: Int?
    var phoneNumber: String?
    var resetMethod: String = "phone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        phonePasswordTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setupUI() {
        if screenType == .forgotPassword {
            phonePasswordLabel.text = "Phone"
            sendButton.setTitle("SEND", for: .normal)
            phonePasswordTextfield.attributedPlaceholder = NSAttributedString(string: "write phone number".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
            phonePasswordTextfield.keyboardType = .phonePad
            title = "Forgot Password"
            
        }
        
        if screenType == .newPassword {
            sendButton.setTitle("CHANGE", for: .normal)
            phonePasswordLabel.text = "New Password"
            
            countryCodeLabel.isHidden = true
            phonePasswordTextfield.attributedPlaceholder = NSAttributedString(string: "New Password".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
            phonePasswordTextfield.leftPadding = 8
            phonePasswordTextfield.keyboardType = .default
            phonePasswordTextfield.isSecureTextEntry = true
            title = "Forgot Password"
        }
        
        if screenType == .changePassword {
            
        }
        
        //Customizing Keyboard with Done Button
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexableSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([flexableSpace, doneButton], animated: true)
        phonePasswordTextfield.inputAccessoryView = toolBar
        
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        if screenType == .forgotPassword {
            if !validation() {
                print("Not Valid")
                phonePasswordTextfield.layer.borderColor = ColorConstant.textFieldError.cgColor
            }
            
            if validation() {
                phonePasswordTextfield.layer.borderColor = ColorConstant.textFieldBorder.cgColor
                StartLoading()
                let phoneNumber = "966-" + phonePasswordTextfield.text!
                print(phoneNumber)
                API.shared.phoneRegister(phone: phoneNumber) { (code, success, error) in
                    print("INSIDE HERE")
                    if let error = error {
                        self.StopLoading()
                        print("MESSAGE: \(error)")
                        API.shared.forgotPassword(phoneNumber: phoneNumber, resetMethod: "phone") { (code, success, error) in
                            if success {
                                
                                self.StopLoading()
                                
                                let code = code
                                self.code = code
                                print("Code: \(code)")
                                
                                let viewController = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "ActivationVC") as! ActivationVC
                                viewController.activeType = .reset_password
                                viewController.code = code
                                viewController.phoneNumber = phoneNumber
                                viewController.title = "Forgot Password"
                                viewController.titleHead = "Forgot Password"
                                viewController.codeActivation = true
                                viewController.message = "Code \(code)"
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                        }
                    } else {
                        self.StopLoading()
                        self.DangerAlert(message: "There's No Account With This Number!")
                        
                    }
                }
                
            }
        }
        
        if screenType == .newPassword {
            if !validation() {
                print("Not Valid")
                phonePasswordTextfield.layer.borderColor = ColorConstant.textFieldError.cgColor
            }
            
            if validation() {
                phonePasswordTextfield.layer.borderColor = ColorConstant.textFieldBorder.cgColor
                StartLoading()
                let newPassword =  phonePasswordTextfield.text!
                print(phoneNumber)
                let stringCode = String(code!)
                
                API.shared.resetPasswordByCode(phoneNumber: phoneNumber!, reset_password_code: stringCode, password: newPassword, reset_method: "phone") { (data, success, error) in
                    
                    if success! {
                        
                        if (NetworkManager.shared.connected) {
                            self.StopLoading()
                            self.DangerAlert(message: "No Internet Connection".Localize)
                        }
                        
                        
                        if let error = error {
                            self.StopLoading()
                            self.DangerAlert(message: error)
                        }
                        
                        if let data = data {
                            self.StopLoading()
                            //print("======> user \(user.activation ?? 0)")
                            self.view.endEditing(true)
                            self.phonePasswordTextfield.text = ""
                            
                            let successVC = SuccessVC()
                            successVC.modalPresentationStyle = .custom
                            self.present(successVC, animated: true, completion: nil)
                            
                        }
                    }
                }
                
            }
        }
    }
    
    func validation() -> Bool {
        if screenType == .forgotPassword {
            var fields = [ValidationData]()
            fields.append(ValidationData(value: phonePasswordTextfield.text! ,name : "Phone Email".Localize , type:"required|phone"))
            
            return Validation.instance.SetValidation(ValidationData: fields)
        }
        if screenType == .newPassword {
            var fields = [ValidationData]()
            fields.append(ValidationData(value: phonePasswordTextfield.text! ,name : "Phone Email".Localize , type:"required|min:6|password"))
            
            return Validation.instance.SetValidation(ValidationData: fields)
        }
        
        return false
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    
    
}



extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Wornkingisjf")
        textField.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.borderColor = ColorConstant.textFieldBorder.cgColor
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if screenType == .forgotPassword {
//            guard let text = phonePasswordTextfield.text else { return true }
//            let newLength = text.characters.count + string.characters.count - range.length
//            return newLength <= 9 // Bool
//        }
//        return false
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}


