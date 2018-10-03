//
//  ActivationVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/19/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

enum activeType {
    case register
    case update_phone
    case reset_password
    case reset_phone
}

class ActivationVC: RootViewController {
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var activateButton: UIButtonX!
    @IBOutlet weak var resendButtonOutlet: UIButton!
    @IBOutlet weak var resendTimerLabel: UILabel!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var didntReceiveLabel: UILabel!

    var code: Int?
    var count: Int = 30
    var codeActivation: Bool = false
    
    //Alert Debug - Delete when Testing
    var titleHead: String?
    var message: String?
    //End of alert Debug
    
    var phoneNumber: String?
    var activeType: activeType?
    var userIndexType: Int?
    
    @IBOutlet weak var code1: UITextView! {
        didSet {
            code1.delegate = self
            code1.textAlignment = .center
            code1.contentInset = UIEdgeInsets(top: -3, left: 0, bottom: 10, right: 0)
        }
    }
    
    @IBOutlet weak var code2: UITextView! {
        didSet {
            code2.delegate = self
            code2.textAlignment = .center
            code2.contentInset = UIEdgeInsets(top: -3, left: 0, bottom: 10, right: 0)
        }
    }
    
    @IBOutlet weak var code3: UITextView! {
        didSet {
            code3.delegate = self
            code3.textAlignment = .center
            code3.contentInset = UIEdgeInsets(top: -3, left: 0, bottom: 10, right: 0)
        }
    }
    
    @IBOutlet weak var code4: UITextView! {
        didSet {
            code4.delegate = self
            code4.textAlignment = .center
            code4.contentInset = UIEdgeInsets(top: -3, left: 0, bottom: 10, right: 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if title != "" && message != "" {
            callAlert(title: titleHead!, message: message!)
        }
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func activateButtonPressed(_ sender: Any) {
        print("Code Activation \(codeActivation)")
        if codeActivation {
            //Transfer Data to new Password Screen
            let newPasswordVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
            newPasswordVC.phoneNumber = phoneNumber
            newPasswordVC.code = code
            newPasswordVC.screenType = .newPassword
            self.navigationController?.pushViewController(newPasswordVC, animated: true)
        } else {
            
            if let userInput = getUserInput() {
                print(userInput)
                if let code = self.code {
                    if code == userInput {
                        successState()
                        self.StartLoading()
                        API.shared.activateUser(apiToken: (SavedUser.loadUser()?.apiToken)!, code: code) { (dictionary, success, error) in
                            if success! {
                                self.StopLoading()
                                if self.userIndexType == 1 {
                                    let completeRegistrationVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "CompleteRegisterationVC") as! CompleteRegisterationVC
                                    completeRegistrationVC.title = "Bank Account"
                                    completeRegistrationVC.userType = .user
                                    self.navigationController?.pushViewController(completeRegistrationVC, animated: true)
                                    print("USER ACCOUNT ACTIVATED")
                                } else if self.userIndexType == 2 {
                                    let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBarVC") as! HomeTabBarVC
                                    self.present(homeVC, animated: true, completion: nil)
                                }
                            } else {
                                self.StopLoading()
                                self.DangerAlert(message: "Code Mismatch")
                            }
                        }
            
                    }
                }
                
            } else {
                callAlert(title: "Activation", message: "Activation Fails!")
                wrongState()
            }
        }

    }

    @IBAction func resendActivationButtonPressed(_ sender: Any) {
        if activeType == .register {
            if resendTimerLabel.text == "00:00" {
                self.count = 30
                self.updateCounter()
                resendButtonOutlet.isEnabled = false
                
                if activeType == .register {
                    StartLoading()
                    
                    API.shared.resendActivationCode(apiToken: SavedUser.loadUser()?.apiToken ?? "") { (code, success, error)  in
                        if success {
                            self.StopLoading()
                            print(code)
                            self.callAlert(title: "Code", message: String(code!))
                            self.code = code
                        }
                    }
                }
            }
        } else if activeType == .reset_password {
            StartLoading()
            
            API.shared.forgotPassword(phoneNumber: phoneNumber!, resetMethod: "phone") { (code, success, error) in
                if success {
                    self.StopLoading()
                    
                    let code = code
                    self.code = code
                    print("Code: \(code)")
                    self.callAlert(title: "Code Again", message: "\(code)")
                }
            }
        }
    }

}

extension ActivationVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == code1  {
            if code1.text.count > 0 {

            }
            else {
                code1.becomeFirstResponder()
            }
        }
        if textView == code2  {
            if code2.text.count > 0 {

            }
            else {
                code2.becomeFirstResponder()
            }
        }
        if textView == code3  {
            if code3.text.count > 0 {

            } else {
                code3.becomeFirstResponder()
            }
        }
        if textView == code4  {
            if code4.text.count > 0 {
                
            }
            else {
                code4.becomeFirstResponder()
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == code1  {
            if code1.text != ""
            {
                code1.resignFirstResponder()
                line1.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                code2.becomeFirstResponder()
            }
            if code1.text == "" {
                line1.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            if code1.text.count > 1 {
                code1.text.removeLast()
            }
        }
        
        if textView == code2 {
            if code2.text != ""
            {
                code2.resignFirstResponder()
                line2.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                code3.becomeFirstResponder()
            }
            if code2.text == ""
            {
                code2.resignFirstResponder()
                line2.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                code1.becomeFirstResponder()
            }
            if code2.text.count > 1 {
                code2.text.removeLast()
            }
        }
        
        if textView == code3 {
            if code3.text != "" {
                code3.resignFirstResponder()
                line3.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                code4.becomeFirstResponder()
            }
            if code3.text == "" {
                code3.resignFirstResponder()
                line3.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                code2.becomeFirstResponder()
            }
            if code3.text.count > 1 {
                code3.text.removeLast()
            }
        }
        
        if textView == code4 {
            if code4.text != "" {
                code4.resignFirstResponder()
                line4.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                if let userInput = getUserInput()
                {
                    print(userInput)
                    if let code = self.code {
                        if code == userInput {
                            successState()
                            print("USER ACCOUNT ACTIVATED")
                        }
                        else
                        {
                            //callAlert(title: "Activation", message: "Activation Fails!")
                            wrongState()
                        }
                    }
                }
            }
            if code4.text == ""
            {

                code4.resignFirstResponder()
                line4.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                code3.becomeFirstResponder()
            }
            
        }
        
    }
    
    private func getUserInput() -> Int? {
        if let code1 = Int(code1.text), let code2 = Int(code2.text), let code3 = Int(code3.text), let code4 = Int(code4.text) {
            let activation = Int("\(code1)\(code2)\(code3)\(code4)")
            return activation
        }
        return nil
    }
    
    
    func successState() {
        line1.backgroundColor = ColorConstant.blue
        line2.backgroundColor = ColorConstant.blue
        line3.backgroundColor = ColorConstant.blue
        line4.backgroundColor = ColorConstant.blue
    }
    
    func wrongState() {
        //WarningAlert(message: "Code is wrong, please try again".locale) // error here....
        
        line1.backgroundColor = UIColor.red
        line2.backgroundColor = UIColor.red
        line3.backgroundColor = UIColor.red
        line4.backgroundColor = UIColor.red
    }
    
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setupUI() {
        code1.font = UIFont.systemFont(ofSize: 30)
        code2.font = UIFont.systemFont(ofSize: 30)
        code3.font = UIFont.systemFont(ofSize: 30)
        code4.font = UIFont.systemFont(ofSize: 30)
        
        textMessageLabel.text = "Please full the activation code below".Localize
        activateButton.setTitle("ACTIVATE".Localize, for: .normal)
        didntReceiveLabel.text = "Didn't Receive Activation Code?".Localize
        resendButtonOutlet.setTitle("Resend".Localize, for: .normal)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func updateCounter() {
        if(count > 0) {
            //print(count - 1)
            resendTimerLabel.text = "00:\((count - 1))"
            count = count - 1
            resendButtonOutlet.isEnabled = false
        } else {
        }
        
        if(count == 0) {
            resendTimerLabel.text = "00:00"
            resendButtonOutlet.isEnabled = true
            resendButtonOutlet.setTitleColor(#colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1), for: .normal)
        }
    }

}


