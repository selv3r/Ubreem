//
//  CompleteRegisterationVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/21/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import CFAlertViewController
import Lightbox

enum UserRegistrationType {
    case user
    case driver
}

enum UploadedImageType {
    case nationalId
    case drivingLicense
    case vechileRegistration
    case criminalRecord
}

class CompleteRegisterationVC: UITableViewController, UserDidSelectBank {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var iBanNumberTextfield: UITextField!
    @IBOutlet weak var accountOwnerTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButtonX!
    @IBOutlet weak var bankButtonOutlet: UIButtonX!
    
    //UIImages Buttons for Layout
    @IBOutlet weak var nationalIdOutlet: UIButton!
    @IBOutlet weak var vechileRegOutlet: UIButton!
    @IBOutlet weak var driverLicOutlet: UIButton!
    @IBOutlet weak var criminalRecOutlet: UIButton!
    
    
    //UIImages
    @IBOutlet weak var nationalIdentityImage: UIImageView!
    @IBOutlet weak var vechileRegistrationImage: UIImageView!
    @IBOutlet weak var drivingLicenseImage: UIImageView!
    @IBOutlet weak var criminalRecordImage: UIImageView!
    
    
    //UIUploadButtons
    @IBOutlet weak var uploadNationalIdButton: UIButton!
    @IBOutlet weak var uploadVechileRegButton: UIButton!
    @IBOutlet weak var uploadDrivingLicenseButton: UIButton!
    @IBOutlet weak var uploadCriminalRecordButton: UIButton!
    
    
    @IBOutlet weak var previewNationalIdButton: UIButton!
    @IBOutlet weak var previewVechileRegButton: UIButton!
    @IBOutlet weak var previewDrivingLicenseButton: UIButton!
    @IBOutlet weak var previewCriminalRecordButton: UIButton!
    
    
    //MARK: - DRIVER REGISTRATION INFO COMING FROM SIGNUP SCREEN
    //Sign Up as a Driver
    var userIndexType: Int?
    var firstName: String?
    var lastName: String?
    var countryId: Int?
    var cityId: Int?
    var password: String?
    var phoneNumber: String?
    
    //UIImageButton
    var userType: UserRegistrationType?
    var banks: [Bank] = []
    var bankName: String?
    var bankId: Int = 0
    var uploadedImageType: UploadedImageType!
    
    //Images Vars
    var imageSelectedNationalIdCheck: Bool = false
    var imageSelectedVechileRegCheck: Bool = false
    var imageSelectedDrivingLicenseCheck: Bool = false
    var imageSelectedCriminalRecordCheck: Bool = false
    
    var imageSelectedNationalId = UIImage()
    var imageSelectedVechileReg = UIImage()
    var imageSelectedDrivingLicense = UIImage()
    var imageSelectedCriminalRecord = UIImage()
    
    var nationalIdentityString: String?
    var vechileRegistraionString: String?
    var drivingLicenseString: String?
    var criminalRecordString: String?
    
    var images = [UIImage]()
    var imagesLarge = [UIImage]()
    var itemGetImages: (([UIImage]) -> ())?
    var imageSelected: Bool = false
    var imageArray = [String]()
    
    var imageType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBanks()
        setupUI()
        print("USER INDEX TYPE: \(userIndexType)")
        print("API TOKEN: \(SavedUser.loadUser()?.apiToken)")
        
        if userType == .user {
            let skipButton = UIBarButtonItem(title: "SKIP", style: .plain, target: self, action: #selector(skipAction))
            self.navigationItem.rightBarButtonItem  = skipButton
        }
    }
    
    func setupUI() {
        previewNationalIdButton.isHidden = true
        previewVechileRegButton.isHidden = true
        previewDrivingLicenseButton.isHidden = true
        previewCriminalRecordButton.isHidden = true
        
        if userType == .user {
            imageView.image = UIImage(named: "credit-card")
            title = "Bank Account"
        } else {
            imageView.image = UIImage(named: "delivery-man")
            title = "Driver Registration"
            print("Driver Name: \(firstName!) \(lastName!)")
        }
    }

    @objc func skipAction() {
        if SavedUser.loadUser()?.type == 1 {
            let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBarVC") as! HomeTabBarVC
            self.present(homeVC, animated: true, completion: nil)
        } else {
            callAlert(title: "Driver Data Required", message: "You can't skip as you've registered as a Driver!")
        }
    }
    
    
    //MARK: - IBACTIONS UPLOADING DRIVER DATA
    @IBAction func nationalIdButtonPressed(_ sender: Any) {
        if !imageSelectedNationalIdCheck {
            imageType = "nationalIdentity"
            uploadedImageType = .nationalId
            showAlertCamera()
        } else {
            imageSelectedNationalId = UIImage()
            uploadNationalIdButton.setTitle("Upload", for: .normal)
            uploadNationalIdButton.titleLabel?.textColor = ColorConstant.darkBlue
            imageSelectedNationalIdCheck = false
            previewNationalIdButton.isHidden = true
            //handleSelectedImageURL(image: selectedImage)
        }
    }
    
    @IBAction func vechileRegButtonPressed(_ sender: Any) {
        if !imageSelectedVechileRegCheck {
            imageType = "vechileRegistration"
            uploadedImageType = .vechileRegistration
            showAlertCamera()
        } else {
            imageSelectedVechileReg = UIImage()
            uploadVechileRegButton.setTitle("Upload", for: .normal)
            uploadVechileRegButton.titleLabel?.textColor = ColorConstant.darkBlue
            imageSelectedVechileRegCheck = false
            previewVechileRegButton.isHidden = true
        }
    }
    
    
    @IBAction func drivingLicenseButtonPressed(_ sender: Any) {
        if !imageSelectedDrivingLicenseCheck {
            imageType = "drivingLicense"
            uploadedImageType = .drivingLicense
            showAlertCamera()
        } else {
            imageSelectedDrivingLicense = UIImage()
            uploadDrivingLicenseButton.setTitle("Upload", for: .normal)
            uploadDrivingLicenseButton.titleLabel?.textColor = ColorConstant.darkBlue
            imageSelectedDrivingLicenseCheck = false
            previewDrivingLicenseButton.isHidden = true
        }
    }
    
    
    @IBAction func criminalRecButtonPressed(_ sender: Any) {
        if !imageSelectedCriminalRecordCheck {
            imageType = "criminalRecord"
            uploadedImageType = .criminalRecord
            showAlertCamera()
        } else {
            imageSelectedCriminalRecord = UIImage()
            uploadCriminalRecordButton.setTitle("Upload", for: .normal)
            uploadCriminalRecordButton.titleLabel?.textColor = ColorConstant.darkBlue
            imageSelectedCriminalRecordCheck = false
            previewCriminalRecordButton.isHidden = true
        }
    }
    
    //MARK: - PREVIEW IMAGES
    @IBAction func previewNationalIdButtonPressed(_ sender: Any) {
        if imageSelectedNationalIdCheck {
            let image = nationalIdentityString!
            print(image)
            openImages([image], startIndex: 0)
        }
    }
    
    @IBAction func previewVechileRegButtonPressed(_ sender: Any) {
        if imageSelectedVechileRegCheck {
            let image = vechileRegistraionString!
            print(image)
            openImages([image], startIndex: 0)
        }
    }
    
    
    @IBAction func previewDrivingLicenseButtonPressed(_ sender: Any) {
        if imageSelectedDrivingLicenseCheck {
            let image = drivingLicenseString!
            print(image)
            openImages([image], startIndex: 0)
        }
    }
    
    
    @IBAction func previewCriminalRecButtonPressed(_ sender: Any) {
        if imageSelectedCriminalRecordCheck {
            let image = criminalRecordString!
            print(image)
            openImages([image], startIndex: 0)
        }
    }
    
    
    @IBAction func BankNameButtonPressed(_ sender: Any) {
        let bankVC = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "SelectBankVC") as? SelectBankVC
        bankVC?.protocolType = self
        bankVC?.banks = self.banks
        bankVC?.bankName = self.bankName
        self.navigationController?.pushViewController(bankVC!, animated: true)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if userType == .driver {
            nationalIdOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
            vechileRegOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
            driverLicOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
            criminalRecOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        }
        
        bankButtonOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        iBanNumberTextfield.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        
        if !validation() {
            iBanNumberTextfield.layer.borderColor = ColorConstant.textFieldError.cgColor
        }
        
        if validation() {
            
            bankButtonOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
            iBanNumberTextfield.layer.borderColor = ColorConstant.textFieldBorder.cgColor
            
            if userIndexType == 1 {
                StartLoading()
                
                API.shared.completeRegistraion(apiToken: (SavedUser.loadUser()?.apiToken)!, firstname: (SavedUser.loadUser()?.firstname)!, lastname: (SavedUser.loadUser()?.lastname)!, countryId: (SavedUser.loadUser()?.countryId)!, cityId: (SavedUser.loadUser()?.cityId)!, bankId: bankId, bankNumber: iBanNumberTextfield.text!) { (data, success, error) in
                    
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
                            let user = data
                            SavedUser.saveUser(user)
                            self.view.endEditing(true)
                            self.bankId = 0
                            self.bankNameLabel.text = "Bank Name"
                            self.bankName = ""
                            self.iBanNumberTextfield.text = ""
                            
                            let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBarVC") as! HomeTabBarVC
                            self.present(homeVC, animated: true, completion: nil)
                        }
                    }
                    
                }
                
                
                
            } else if userIndexType == 2 {
                print("USER INDEX TYPE: \(userIndexType ?? 0)")
                nationalIdOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
                vechileRegOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
                driverLicOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
                criminalRecOutlet.layer.borderColor = ColorConstant.textFieldBorder.cgColor
                
                let parameters = [
                    "first_name": firstName!,
                    "last_name": lastName!,
                    "phone": phoneNumber!,
                    "password": password!,
                    "type": userIndexType!,
                    "country_id": countryId!,
                    "city_id": cityId!,
                    "bank_id": bankId,
                    "bank_number": iBanNumberTextfield.text!,
                    "national_identity": nationalIdentityString!,
                    "driving_license": drivingLicenseString!,
                    "vehicle_registration": vechileRegistraionString!,
                    "clearance_criminal": criminalRecordString!
                    ] as [String : Any]
                
                API.shared.signUp(with: parameters) { [weak self](user, success, error) in
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
                        
                        let viewController = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "ActivationVC") as! ActivationVC
                        viewController.activeType = .register
                        viewController.userIndexType = 2
                        print("ACTIVATION SCREEEEEEEEEN")
                        viewController.titleHead = "Activation Code"
                        viewController.message = "\(SavedUser.loadUser()?.activation)"
                        viewController.code = SavedUser.loadUser()?.activation
                        viewController.title = "Mobile Verification"
                        self?.navigationController?.pushViewController(viewController, animated: true)
                        print("USER REGISTERED SUCCESSFULLY")
                    }
                }
//
//                API.shared.completeRegistrationAsDriver(apiToken: (SavedUser.loadUser()?.apiToken)!, firstname: (SavedUser.loadUser()?.firstname)!, lastname: (SavedUser.loadUser()?.lastname)!, countryId: (SavedUser.loadUser()?.countryId)!, cityId: (SavedUser.loadUser()?.cityId)!, bankId: bankId, bankNumber: iBanNumberTextfield.text!, nationalIdImage: nationalIdentityString!, vechileRegImage: vechileRegistraionString!, drivingLicenseimage: drivingLicenseString!, criminalRecordImage: criminalRecordString!) { (data, success, error) in
//                    
//                    if success! {
//                        
//                        if (NetworkManager.shared.connected) {
//                            self.StopLoading()
//                            self.DangerAlert(message: "No Internet Connection".Localize)
//                        }
//                        
//                        
//                        if let error = error {
//                            self.StopLoading()
//                            self.DangerAlert(message: error)
//                        }
//                        
//                        if let data = data {
//                            self.StopLoading()
//                            let user = data
//                            SavedUser.saveUser(user)
//                            self.view.endEditing(true)
//                            self.bankId = 0
//                            self.bankNameLabel.text = "Bank Name"
//                            self.bankName = ""
//                            self.iBanNumberTextfield.text = ""
//                            
//                            print("Complete Registration")
//                            
//                        }
//                        
//                    }
//                   
//                }
//                
            }
            
        }
        
    }
    
    
    func loadBanks() {
        self.banks = []
        API.shared.loadCountries { (country, bank, error)  in
            self.banks = bank ?? []
            print("BANKS", self.banks)
            
        }
    }
    
    func getBankId(name: String, index: Int) {
        if name == "" || name == "Bank Name" {
            bankName = "Bank Name"
            bankNameLabel.text = "Bank Name"
            bankId = 0
            bankNameLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            bankName = name
            bankNameLabel.text = name
            bankId = index
            bankNameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            print("Name of country is \(bankName) with Index \(bankId)")
        }
    
    }
    
    func validation() -> Bool {
        
        if bankId == 0 {
            bankButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        }
        
        if userIndexType == 2 {
            if !imageSelectedNationalIdCheck {
                nationalIdOutlet.layer.borderColor = ColorConstant.textFieldError.cgColor
            }
            if !imageSelectedVechileRegCheck {
                vechileRegOutlet.layer.borderColor = ColorConstant.textFieldError.cgColor
            }
            if !imageSelectedDrivingLicenseCheck {
                driverLicOutlet.layer.borderColor = ColorConstant.textFieldError.cgColor
            }
            if !imageSelectedCriminalRecordCheck {
                criminalRecOutlet.layer.borderColor = ColorConstant.textFieldError.cgColor
            }
        }
        
        
        var fields = [ValidationData]()
        
        fields.append(ValidationData(value: iBanNumberTextfield.text! ,name : "iBan Number".Localize , type:"required"))
        
        return Validation.instance.SetValidation(ValidationData: fields)
    }
    
    

}




extension CompleteRegisterationVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Wornkingisjf")
        textField.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.borderColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == iBanNumberTextfield {
            let str = (NSString(string: textField.text!)).replacingCharacters(in: range, with: string)
            if str.characters.count <= 34 {
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


extension CompleteRegisterationVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }
        if indexPath.row <= 4 {
            if SavedUser.loadUser()?.type == 1 {
                return 0
            } else {
                return 90
            }
        }
        if indexPath.row > 4 {
            return 90
        }
        return 90
    }
    
    func alertView(_ title:String) ->  CFAlertViewController {
        // Create Alet View Controller
        let alertController = CFAlertViewController(title: title,
                                                    titleColor: ColorConstant.mainColor ,
                                                    message: nil,
                                                    messageColor: nil,
                                                    textAlignment: .center,
                                                    preferredStyle: .actionSheet,
                                                    headerView: nil,
                                                    footerView: nil,
                                                    didDismissAlertHandler: nil)
        return alertController
    }


    
    func showAlertCamera() {
        // Create Alet View Controller
        let alertController = alertView("")
        
        // photo Library Action
        let defaultAction = CFAlertAction(title: "Gallery".Localize,
                                          style: .Default,
                                          alignment: .justified,
                                          backgroundColor: ColorConstant.mainColor,
                                          textColor: .black,
                                          handler: { (action) in
                                            self.PresentImagePicker()
                                            
        })
        
        // camera Action
        let cameraAction = CFAlertAction(title:  "Camera".Localize,
                                         style: .Default,
                                         alignment: .justified,
                                         backgroundColor: ColorConstant.gray ,
                                         textColor: .black,
                                         handler: { (action) in
                                            self.presentCameraImagePicker()
                                            
        })
        // Create Cancel Action
        let cancelAction = CFAlertAction(title: "Cancel".Localize,
                                         style: .Default,
                                         alignment: .justified,
                                         backgroundColor: ColorConstant.lightGray ,
                                         textColor: .black,
                                         handler: nil)
        // Add Action Button Into Alert
        alertController.addAction(defaultAction)
        // Add Action Button Into Alert
        alertController.addAction(cameraAction)
        // Add Action Button Into Alert
        alertController.addAction(cancelAction)
        // Present Alert View Controller
        present(alertController, animated: true, completion: nil)
    }
    
    func PresentImagePicker() {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = .photoLibrary
        ImagePicker.allowsEditing = true
        UIApplication.topViewController()?.present(ImagePicker, animated: true, completion: nil)
    }
    
    func presentCameraImagePicker() {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = .camera
        ImagePicker.allowsEditing = true
        UIApplication.topViewController()?.present(ImagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        if imageType == "nationalIdentity" {
            imageSelectedNationalId = selectedImage
            nationalIdentityImage.image = UIImage(named: "upload_pic")
            uploadNationalIdButton.setTitle("Remove", for: .normal)
            uploadNationalIdButton.titleLabel?.textColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            imageSelectedNationalIdCheck = true
            previewNationalIdButton.isHidden = false
            handleSelectedImageURL(image: selectedImage)
        } else if imageType == "vechileRegistration" {
            imageSelectedVechileReg = selectedImage
            vechileRegistrationImage.image = UIImage(named: "upload_pic")
            uploadVechileRegButton.setTitle("Remove", for: .normal)
            uploadVechileRegButton.titleLabel?.textColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            imageSelectedVechileRegCheck = true
            previewVechileRegButton.isHidden = false
            handleSelectedImageURL(image: selectedImage)
        } else if imageType == "drivingLicense" {
            imageSelectedDrivingLicense = selectedImage
            drivingLicenseImage.image = UIImage(named: "upload_pic")
            uploadDrivingLicenseButton.setTitle("Remove", for: .normal)
            uploadDrivingLicenseButton.titleLabel?.textColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            imageSelectedDrivingLicenseCheck = true
            previewDrivingLicenseButton.isHidden = false
            handleSelectedImageURL(image: selectedImage)
        } else {
            imageSelectedCriminalRecord = selectedImage
            criminalRecordImage.image = UIImage(named: "upload_pic")
            uploadCriminalRecordButton.setTitle("Remove", for: .normal)
            uploadCriminalRecordButton.titleLabel?.textColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            imageSelectedCriminalRecordCheck = true
            previewCriminalRecordButton.isHidden = false
            handleSelectedImageURL(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    

    
    func handleSelectedImageURL(image: UIImage) {
        StartLoading()
        Loader.shared.uploadData(image: image, video: nil, pdfFile: nil, audio: nil, url: URLs.uploadFile, api_token: SavedUser.loadUser()?.apiToken ?? "") { (error, json, uploaded) in
            
            print("JSON \(json)")
            if let error = error {
                print(error)
            }
            if let uploaded = uploaded {
                print(uploaded)
                
            }
            if let json = json {
                self.StopLoading()
                if let fileURL = json["path"].string {
                    print("File is: \(fileURL)")
                    switch self.uploadedImageType {
                    case .nationalId:
                        // present photo edit here
                        self.imageSelectedNationalId = image
                        //self.nationalIdentityImage.image = image
                        self.nationalIdentityString = fileURL
                        self.imageSelectedNationalIdCheck = true
                        
                        break
                    case .vechileRegistration:
                        self.imageSelectedVechileReg = image
                        //self.vechileRegistrationImage.image = image
                        self.vechileRegistraionString = fileURL
                        self.imageSelectedVechileRegCheck = true
                        break
                    case .drivingLicense:
                        self.imageSelectedDrivingLicense = image
                        //self.drivingLicenseImage.image = image
                        self.drivingLicenseString = fileURL
                        self.imageSelectedDrivingLicenseCheck = true
                        break
                    case .criminalRecord:
                        // present phonto
                        self.imageSelectedCriminalRecord = image
                        //self.criminalRecordImage.image = image
                        self.criminalRecordString = fileURL
                        self.imageSelectedCriminalRecordCheck = true
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    
}

extension UIView {
    
    
}





