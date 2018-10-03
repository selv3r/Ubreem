//
//  SignUpContainerVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/17/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover
import CFAlertViewController
import NVActivityIndicatorView

class SignUpContainerVC: RootTableViewController, addUserType, UserDidSelectCountry, UserDidSelectCity {
   

    //Outlets
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var cityCodeLabel: UILabel!
    @IBOutlet weak var userTypeView: UIView!
    @IBOutlet weak var userTypeButtonOutlet: UIButtonX!
    @IBOutlet weak var countryButtonOutlet: UIButton!
    @IBOutlet weak var cityButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var pleaseReadLabel: UILabel!
    @IBOutlet weak var termsAndConditionsButtonOutlet: UIButton!
    
    //Variables
    var popover = Popover()
    var UserIndexType: Int = 0
    
    var countries: [Country] = []
    var banks:[Bank] = []
    var cities: [City] = []
    
    var countryName: String?
    var countryId: Int = 0
    
    var cityName: String?
    var CityId: Int = 0
    
    var termsButtonClicked: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadCountries()
        tableView.allowsSelection = false
        print(NetworkManager.shared.connected)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
        
        //Textfields Delegates
        firstNameTextfield.delegate = self
        lastNameTextfield.delegate = self
        passwordTextfield.delegate = self
        phoneNumberTextfield.delegate = self
        
    }
    
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setupUI() {
        
        //keyWordsTextField.attributedPlaceholder = NSAttributedString(string: "Key Words".Localize , attributes:[NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        //Labels and Button Localization
        userTypeLabel.text = "Customer".Localize
        countryLabel.text = "Country".Localize
        cityLabel.text = "City".Localize
        signUpButtonOutlet.setTitle("Sign Up".Localize, for: .normal)
        pleaseReadLabel.text = "Please read our".Localize
        termsAndConditionsButtonOutlet.setTitle("Terms and Conditions".Localize, for: .normal)
        cityCodeLabel.text = "966-".Localize
        
        firstNameTextfield.attributedPlaceholder = NSAttributedString(string: "First Name".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        lastNameTextfield.attributedPlaceholder = NSAttributedString(string: "Last Name".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Password".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        phoneNumberTextfield.attributedPlaceholder = NSAttributedString(string: "Phone Number".Localize, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexableSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([flexableSpace, doneButton], animated: true)
        
        phoneNumberTextfield.inputAccessoryView = toolBar
        passwordTextfield.inputAccessoryView = toolBar
        firstNameTextfield.inputAccessoryView = toolBar
        lastNameTextfield.inputAccessoryView = toolBar
    }
    
    

    
    //MARK: - IBActions
    @IBAction func UserTypeButtonPressed(_ sender: Any) {
        setupUserPopover()
    }
    
    @IBAction func countryButtonPressed(_ sender: Any) {
        let countryViewController = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "SelectCountryTableViewController") as? SelectCountryTableViewController
        countryViewController?.protocolType = self
        countryViewController?.countries = self.countries
        countryViewController?.countryName = self.countryName
        self.navigationController?.pushViewController(countryViewController!, animated: true)
    }
    
    @IBAction func cityButtonPressed(_ sender: Any) {
        if countryId == 0 {
            self.DangerAlert(message: "Please Select Your Country First")
        } else {
            print("Country Id: \(countryId)")
            let selectedCountry = countries.filter{ $0.id == countryId }
            self.cities = selectedCountry[0].cities!
            let cityViewController = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "SelectCityTableViewController") as? SelectCityTableViewController
            cityViewController?.protocolType = self
            cityViewController?.cities = self.cities
            cityViewController?.cityName = self.cityName
            self.navigationController?.pushViewController(cityViewController!, animated: true)
        }
    }
    
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: Any) {
        let termsVC = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditionsVC") as? TermsAndConditionsVC
        self.navigationController?.pushViewController(termsVC!, animated: true)
    }
    
    
    @IBAction func checkTermButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            termsButtonClicked = -1
        } else {
            sender.isSelected = true
            termsButtonClicked = 0
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        userTypeButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        countryButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        cityButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        
        if validation() {
            if UserIndexType == 1 {
                signUpAsUser()
            } else if UserIndexType == 2 {
                let completeRegisterVC  = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "CompleteRegisterationVC") as? CompleteRegisterationVC
                completeRegisterVC?.userType = .driver
                completeRegisterVC?.userIndexType = 2
                completeRegisterVC?.firstName = firstNameTextfield.text!
                completeRegisterVC?.lastName = lastNameTextfield.text!
                completeRegisterVC?.countryId = countryId
                completeRegisterVC?.cityId = CityId
                completeRegisterVC?.password = passwordTextfield.text!
                completeRegisterVC?.phoneNumber = "966-\(phoneNumberTextfield.text!)"
                self.navigationController?.pushViewController(completeRegisterVC!, animated: true)
            }
            print(UserIndexType)
        }
    }
    
    
    
    
    func showUserType(label: String, Index: Int) {
        userTypeLabel.text = label
        UserIndexType = Index
        if UserIndexType == 0 {
            userTypeLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        userTypeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //If User is a Customer
        if UserIndexType == 1 {
            signUpButtonOutlet.setTitle("Sign Up", for: .normal)
        } else {
            signUpButtonOutlet.setTitle("Next", for: .normal)
        }
    }
}



extension SignUpContainerVC {
    
    func setupUserPopover() {
        passwordTextfield.resignFirstResponder()
        phoneNumberTextfield.resignFirstResponder()
        firstNameTextfield.resignFirstResponder()
        lastNameTextfield.resignFirstResponder()
        
        if let userTypeView = Bundle.main.loadNibNamed("UserType", owner: nil, options: nil)?.first as? UserType {
            popover = Popover()
            userTypeView.popover = popover
            userTypeView.protocolType = self
            userTypeView.frame = CGRect(x: 0, y: 0, width: userTypeView.frame.width, height: 100)
            popover.show(userTypeView, fromView: userTypeButtonOutlet)
        }
    }
    
    
    func loadCountries() {
        self.countries = []
        API.shared.loadCountries { (country, bank, error) in
            self.countries = country ?? []
            print("COUNTRIES", self.countries)
        }
    }
    
    
    func getCountryId(name: String, index: Int, clearCityId: Int) {
        if name == "" || name == "Country" {
            countryName = "Country"
            countryLabel.text = "Country"
            countryId = 0
            cityName = "City"
            CityId = 0
            cityLabel.text = "City"
            countryLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            countryName = name
            countryLabel.text = name
            countryId = index
            cityName = "City"
            CityId = 0
            cityLabel.text = "City"
            countryLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            print("Name of country is \(countryName) with Index \(countryId)")
        }
    }
    
    func getCityId(name: String, index: Int) {
        if name == "" || name == "City" {
            cityName = "City"
            cityLabel.text = "City"
            cityLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        } else {
            cityName = name
            cityLabel.text = name
            CityId = index
            cityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

            print("Name of country is \(cityName) with Index \(CityId)")
        }
    }
    
    func signUpAsUser() {
        
        userTypeButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        countryButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        cityButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        
        if validation() {
            
            userTypeButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
            countryButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
            cityButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
            
            StartLoading()
            
            let phoneNumber = "966-" + phoneNumberTextfield.text!
            print(phoneNumber)
            
            var parameters = [
                "first_name": firstNameTextfield.text ?? "",
                "last_name": lastNameTextfield.text ?? "",
                "phone": phoneNumber ?? "",
                "password": passwordTextfield.text ?? "",
                "type": UserIndexType,
                "country_id": countryId,
                "city_id": CityId
                ] as [String : Any]
            
            if UserIndexType == 1 {
                
                API.shared.signUp(with: parameters) { [weak self] (user, success, error) in
                    
                    if !(NetworkManager.shared.connected) {
                        self?.StopLoading()
                        self?.DangerAlert(message: "No Internet Connection")
                        return
                    }
                    
                    if let error = error {
                        print("Error")
                        self?.StopLoading()
                        self?.DangerAlert(message: error)
                    }
                    
                    if let user = user {
                        self?.StopLoading()
                        print("======> user \(user.activation ?? 0)")
                        self?.view.endEditing(true)
                        self?.phoneNumberTextfield.text = ""
                        self?.passwordTextfield.text = ""
                        self?.lastNameTextfield.text = ""
                        self?.firstNameTextfield.text = ""
                        
                        let viewController = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "ActivationVC") as! ActivationVC
                        viewController.activeType = .register
                        viewController.userIndexType = 1
                        viewController.titleHead = "Activation Code"
                        viewController.message = "\(SavedUser.loadUser()?.activation)"
                        viewController.code = SavedUser.loadUser()?.activation
                        viewController.title = "Mobile Verification"
                        self?.navigationController?.pushViewController(viewController, animated: true)
                        print("USER REGISTERED SUCCESSFULLY")
                    }
                }
            }
        }
    }

    
    func validation() -> Bool {
        
        if UserIndexType == 0 {
            //self.DangerAlert(message: "Please Choose User Type!")
            userTypeButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            if countryId == 0 {
                //self.DangerAlert(message: "Please Choose Your Country!")
                countryButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
                if CityId == 0 {
                    //self.DangerAlert(message: "Please Choose Your City!")
                    cityButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
                }
            }
            return false
        }
        
        if countryId == 0 {
            //self.DangerAlert(message: "Please Choose Your Country!")
            countryButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            if CityId == 0 {
                cityButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            }
            return false
        }
        
        if CityId == 0 {
            //self.DangerAlert(message: "Please Choose Your City!")
            cityButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            if countryId == 0 {
                countryButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            }
            return false
        }
        
        var firstNameField = [ValidationData]()
        firstNameField.append(ValidationData(value: firstNameTextfield.text!, name: "First Name", type: "required|min:3"))
        
        if !Validation.instance.SetValidation(ValidationData: firstNameField) {
            colorAlert(textfield: firstNameTextfield)
        }
        
        var lastNameField = [ValidationData]()
        lastNameField.append(ValidationData(value: lastNameTextfield.text!, name: "Last Name", type: "required|min:3"))
        
        if !Validation.instance.SetValidation(ValidationData: lastNameField) {
            colorAlert(textfield: lastNameTextfield)
        }
        
        var phoneField = [ValidationData]()
        phoneField.append(ValidationData(value: phoneNumberTextfield.text!, name: "Last Name", type: "required|phone"))
        
        if !Validation.instance.SetValidation(ValidationData: phoneField) {
            colorAlert(textfield: phoneNumberTextfield)
        }
        
        var passwordField = [ValidationData]()
        passwordField.append(ValidationData(value: passwordTextfield.text!, name: "Password", type: "required|min:6|password"))
        
        if !Validation.instance.SetValidation(ValidationData: passwordField) {
            colorAlert(textfield: passwordTextfield)
            return false
        }
        
        if termsButtonClicked == -1 {
            DangerAlert(message: "Please Read Our Terms and Conditions")
            return false
        }
        
        
        var fields = [ValidationData]()

        fields.append(ValidationData(value: firstNameTextfield.text!, name: "First Name", type: "required|min:3"))
        fields.append(ValidationData(value: lastNameTextfield.text!, name: "Last Name", type: "required|min:3"))
        fields.append(ValidationData(value: phoneNumberTextfield.text! ,name : "Phone Number".Localize , type:"required|phone"))
        fields.append(ValidationData(value: passwordTextfield.text! ,name : "Password".Localize, type:"required|min:6|password"))

        return Validation.instance.SetValidation(ValidationData: fields)
    }
    
    func LoadingStart()  {
        let size = CGSize(width: 50, height: 50)
        NVActivityIndicatorView.DEFAULT_COLOR = ColorConstant.blue
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.startAnimating(size, message: "", type: NVActivityIndicatorType.ballScaleRipple)
    }
    
    func LoadingFinished()  {
        self.stopAnimating()
    }
    
}

extension SignUpContainerVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Wornkingisjf")
        textField.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.borderColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextfield {
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

