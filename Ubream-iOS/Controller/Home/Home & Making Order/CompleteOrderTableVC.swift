//
//  CompleteOrderTableVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import CFAlertViewController

class CompleteOrderTableVC: UITableViewController, UserDidSelectShippingAddressProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - OUTLETS
    @IBOutlet weak var shipmentDescriptionTextView: UITextView!
    @IBOutlet weak var shipmentImage: UIImageView!
    @IBOutlet weak var uploadShipmentLabel: UILabel!
    @IBOutlet weak var selectPickupLocationButton: UILabel!
    @IBOutlet weak var selectDeliveryLocationButton: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var anotherPersonPhoneNumberTextfield: UITextField!
    @IBOutlet weak var shipmentPriceTextfield: UITextField!
    @IBOutlet weak var copounTextfield: UITextField!
    @IBOutlet weak var pickDateTextfield: UITextField!
    @IBOutlet weak var pickTimeTextfield: UITextField!
    
    @IBOutlet weak var recipientNameTextfield: UITextField!
    @IBOutlet weak var recipientPhoneTextfield: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Radio Buttons Outlets
    @IBOutlet weak var pickupDateNowButton: UIButton!
    @IBOutlet weak var pickupDateScheduledTimeButton: UIButton!
    @IBOutlet weak var requestOptionForMeButton: UIButton!
    @IBOutlet weak var requestOptionForAnotherButton: UIButton!
    @IBOutlet weak var shipmentValueYesButton: UIButton!
    @IBOutlet weak var shipmentValueNoButton: UIButton!
    @IBOutlet weak var packingOptionYesButton: UIButton!
    @IBOutlet weak var packingOptionNoButton: UIButton!
    
    @IBOutlet weak var selectPickupLocationButtonOutlet: UIButtonX!
    @IBOutlet weak var selectDestinationButtonOutlet: UIButtonX!
    @IBOutlet weak var selectPaymentMethodButtonOutlet: UIButtonX!
    
    
    var nowButtonSelected: Bool = true
    var forMeButtonSelected: Bool = true
    var shipmentValueButtonSelected: Bool = true
    var packingOptionButtonSelect:Bool = true
    var shipmentImageSelected: Bool = false
    
    var shipmentImageImage = UIImage()
    var imagesString = ""
    var images = [UIImage]()
    var imagesLarge = [UIImage]()
    var itemGetImages: (([UIImage]) -> ())?
    var imageSelected: Bool = false
    var imageArray = [String]()
    
    //MARK: - Variables
    var shipmentDestination: Int?
    var pickUpTime: Int?
    var paymentMethod: Int?
    var requestOptions: Int?
    var shipmentCollection: Int?
    var packingOptions: Int?
    
    var selectedWeight: String?
    var selectedWeightPrice: String?
    
    var totalPrice: Double?
    
    var scheduledDate: String?
    var anotherPersonPhoneNumber: String?
    var shipmentPrice: String?
    var pickupLocation: String?
    var pickupLocationId: Int?

    var pickupDate: String?
    var pickupTime: String?
    
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    
    var destinationAddressName: String?
    var destinationAddressId: Int?
    
    var cityType: CityType?
    
    //MARK: - RADIO BUTTONS CHECKING
    var pickDateRadioButtonCheck: Int = -1
    var requestOptionsButtonCheck: Int = -1
    var shipmentValueCollectionButtonCheck: Int = -1
    var packingOptionsButtonCheck: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Making a New Order"
        setupDateTextfield()
        setupTimeTextfield()
        
        totalPrice = Double(selectedWeightPrice!)
        
    }
    
    //MARK: - IBActions
    @IBAction func imageOfShipmentButtonPressed(_ sender: Any) {
        showAlertCamera()
    }
    
    //Pickup Date Buttons
    @IBAction func nowButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            nowButtonSelected = false
//            pickUpTime = 1
//            pickDateRadioButtonCheck = 1
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            nowButtonSelected = true
            pickUpTime = 1
            pickDateRadioButtonCheck = 1
            pickupDateScheduledTimeButton.isSelected = false
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    @IBAction func scheduledTimeButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            nowButtonSelected = true
//            pickUpTime = 2
//
//            //TODO :- GET DATA FROM DATEPICKER
//
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            nowButtonSelected = false
            pickUpTime = 0
            pickDateRadioButtonCheck = 1
            pickupDateNowButton.isSelected = false
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    
    //TODO: - Complete Payment Method Functionality
    @IBAction func paymentMethodButtonPressed(_ sender: Any) {
        actionSheet(title: "Select Payment Method", actionTitle: "Online Payment", titleColor: UIColor.black, actionTwoTitle: "Pay On Pickup", actionThreeTitle: "Pay On Delivery", cancelTitle: "CANCEL", completionActionOne: { (success) in
            self.paymentMethodLabel.text = "Online Payment"
            self.paymentMethod = 1
            self.paymentMethodLabel.textColor = #colorLiteral(red: 0.03137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        }, completionActionTwo: { (success) in
            self.paymentMethodLabel.text = "Pay On Pickup"
            self.paymentMethod = 2
            self.paymentMethodLabel.textColor = #colorLiteral(red: 0.03137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        }, completionActionThree: { (success) in
            self.paymentMethodLabel.text = "Pay On Delivery"
            self.paymentMethod = 3
            self.paymentMethodLabel.textColor = #colorLiteral(red: 0.03137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        }) { (cancel) in
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    //MARK: - Request Options
    @IBAction func forMeButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            forMeButtonSelected = false
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            forMeButtonSelected = true
            requestOptionsButtonCheck = 1
            requestOptions = 1
            requestOptionForAnotherButton.isSelected = false
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    @IBAction func forAnotherPersonButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            forMeButtonSelected = true
//
//            //TODO:- GET DATA FROM TEXTFIELD
//
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            forMeButtonSelected = false
            requestOptionForMeButton.isSelected = false
            requestOptionsButtonCheck = 1
            requestOptions = 2
            anotherPersonPhoneNumber = anotherPersonPhoneNumberTextfield.text
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    
    @IBAction func selectPickupLocationButtonPressed(_ sender: Any) {
        let selectAddressVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SelectAddressTableVC") as! SelectAddressTableVC
        selectAddressVC.selectedIndex = pickupLocationId
        selectAddressVC.addressId = pickupLocationId
        selectAddressVC.locationType = .pickup
        selectAddressVC.delegate = self
        self.navigationController?.pushViewController(selectAddressVC, animated: true)
    }
    
    
    @IBAction func selectDestinationLocationButtonPressed(_ sender: Any) {
        let selectAddressVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SelectAddressTableVC") as! SelectAddressTableVC
        selectAddressVC.selectedIndex = pickupLocationId
        selectAddressVC.addressId = pickupLocationId
        selectAddressVC.locationType = .destination
        selectAddressVC.delegate = self
        self.navigationController?.pushViewController(selectAddressVC, animated: true)
    }
    
    
    //Shipment Value Collection
    @IBAction func shipmentValueCollectionYesButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            shipmentValueButtonSelected = false
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            shipmentValueButtonSelected = true
            shipmentValueNoButton.isSelected = false
            shipmentValueCollectionButtonCheck = 1
            shipmentCollection = 1
//            shipmentPrice = shipmentPriceTextfield.text
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    @IBAction func shipmentValueCollectionNoButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            shipmentValueButtonSelected = true
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            shipmentValueButtonSelected = false
            shipmentValueCollectionButtonCheck = 1
            shipmentCollection = 2
            shipmentValueYesButton.isSelected = false
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    
    
    
    @IBAction func packingOptionYesButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            packingOptionButtonSelect = false
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            packingOptionButtonSelect = true
            packingOptionNoButton.isSelected = false
            packingOptionsButtonCheck = 1
            packingOptions = 1
            totalPrice = totalPrice! + 5
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }
    
    @IBAction func packingOptionNoButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
//            sender.isSelected = false
//            packingOptionButtonSelect = true
//            self.tableView.reloadDataAnimatedKeepingOffset()
        } else {
            sender.isSelected = true
            packingOptionButtonSelect = false
            packingOptionYesButton.isSelected = false
            packingOptionsButtonCheck = 1
            packingOptions = 0
            totalPrice = Double(selectedWeightPrice!)
            self.tableView.reloadDataAnimatedKeepingOffset()
        }
    }

    @IBAction func proceedToCheckoutButtonPressed(_ sender: Any) {
        
        var iamges = ""
        iamges = "\(imageArray)"
        let _ = iamges.removeFirst()
        let _ = iamges.removeLast()
        imagesString = "\(iamges.replacingOccurrences(of: "\"", with: ""))"
        
        shipmentDescriptionTextView.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        selectPaymentMethodButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        selectDestinationButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        selectPickupLocationButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        recipientPhoneTextfield.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        recipientNameTextfield.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        shipmentPriceTextfield.layer.borderColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        
        
        if validation() {
            print("DONE!!!")
            StartLoading()
            let user = SavedUser.loadUser()
            API.shared.addNewOrder(apiToken: (user?.apiToken!)!, shippingDestination: shipmentDestination!, description: shipmentDescriptionTextView.text!, image: imagesString, pickupType: pickUpTime!, pickupDate: pickDateTextfield.text ?? "", pickupTime: pickTimeTextfield.text ?? "", requestOptions: requestOptions!, senderPhone: anotherPersonPhoneNumberTextfield.text ?? "", paymentMethod: paymentMethod!, shipmentCollection: shipmentCollection!, shipmentValue: shipmentPriceTextfield.text ?? "", packing: packingOptions!, destinationAddressId: destinationAddressId ?? 0, pickupAddressId: pickupLocationId ?? 0, orderWeight: selectedWeight!, WeightPrice: selectedWeightPrice!, actualWeight: "", couponCode: copounTextfield.text ?? "", recipientName: recipientNameTextfield.text!, recipientPhone: recipientPhoneTextfield.text!, itemPrice: "", totalPrice: String(totalPrice!)) { (data, success, error) in
                self.StopLoading()
                print("WE ARE HERE!")
                if let error = error {
                    print("ERROR: \(error)")
                } else {
                    print("WE GOT THE ORDER")
                    self.callAlert(title: "Order Created", message: "Your order has been created! please wait for a driver")
                    print(data)
                }
            }
        }
    }

    
    //MARK: - DATA GETTER
    func getaddressId(addressHeader: String, id: Int) {
        if addressHeader == "" || addressHeader == "Select Pickup Location" {
            pickupLocation = ""
            pickupLocationId = -1
            selectPickupLocationButton.text = "Select Pickup Location"
            selectPickupLocationButton.textColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        } else {
            pickupLocation = addressHeader
            pickupLocationId = id
            selectPickupLocationButton.text = addressHeader
            selectPickupLocationButton.textColor = #colorLiteral(red: 0.03137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        }
    }
    
    func getDestinationAddressId(destinationAddress: String, destinationId: Int, recipientPhone: String) {
        if destinationAddress == "" || destinationAddress == "Select Destination Location" {
            destinationAddressName = ""
            destinationAddressId = -1
            recipientNameTextfield.text = ""
            recipientPhoneTextfield.text = ""
            selectDeliveryLocationButton.text = "Select Destination Location"
            selectPickupLocationButton.textColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
        } else {
            destinationAddressName = destinationAddress
            destinationAddressId = destinationId
            recipientNameTextfield.text = destinationAddress
            recipientPhoneTextfield.text = recipientPhone
            selectDeliveryLocationButton.text = destinationAddress
            selectDeliveryLocationButton.textColor = #colorLiteral(red: 0.03137254902, green: 0.1490196078, blue: 0.1725490196, alpha: 1)
        }
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 16
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 {
            return 150
        }
        if indexPath.row <= 5  || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 10 {
            return 90
        }
        if indexPath.row == 6 {
            if nowButtonSelected {
                return 0
            } else {
                return 50
            }
        }
        
        if indexPath.row == 9 {
            if forMeButtonSelected {
                return 0
            } else {
                return 90
            }
        }
        
        if indexPath.row == 11 {
            //Check for shipment Value Yes or No
            if shipmentValueButtonSelected {
                return 90
            } else {
                if cityType == .international {
                    return 90
                } else {
                    return 0
                }
            }
        }
        if indexPath.row == 12 {
            return 80
        }
        if indexPath.row == 13 {
            if packingOptionButtonSelect {
                return 60
            } else {
                return 0
            }
        }
        if indexPath.row == 14 {
            return 90
        }
        
        if indexPath.row == 15 {
            return 60
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
        self.images.append(selectedImage)
        self.imagesLarge.append(selectedImage)
        print(imageSelected)
        StartLoading()
        API.shared.uploadImageProduct(image: selectedImage) { (value) in
            self.StopLoading()
            let image = "\(value)"
            self.imageArray.append(image)
            print(self.imageArray)
        }
        self.collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let selectedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//
//        shipmentImageImage = selectedImage
//        shipmentImage.image = selectedImage
//        uploadShipmentLabel.text = "Change"
//        shipmentImageSelected = true
//        handleSelectedImageURL(image: selectedImage)
//        dismiss(animated: true, completion: nil)
//    }
    
    
    
    func handleSelectedImageURL(image: UIImage) {
        StartLoading()
        Loader.shared.uploadData(image: image, video: nil, pdfFile: nil, audio: nil, url: URLs.uploadFile, api_token: SavedUser.loadUser()?.apiToken ?? "") { (error, json, uploaded) in
            
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
                }
            }
        }
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func validation() -> Bool {
        
        if shipmentDescriptionTextView.text == "" {
            shipmentDescriptionTextView.layer.borderColor = ColorConstant.textFieldError.cgColor
            return false
        }
        
        if pickDateRadioButtonCheck == -1 {
            DangerAlert(message: "Please Choose Pickup Date!")
            return false
        }

        if requestOptionsButtonCheck == -1 {
            DangerAlert(message: "Please Choose Request Option")
            return false
        }
        
        if shipmentValueCollectionButtonCheck == -1 {
            DangerAlert(message: "Please Choose Shipment Value Collection")
            return false
        }
        
        if packingOptionsButtonCheck == -1 {
            DangerAlert(message: "Please Choose Packing Options")
            return false
        }
        
        if images.count == 0 {
            DangerAlert(message: "Please Choose Shipment Image")
            return false
        }
        
        if paymentMethodLabel.text == "Select Payment Method" {
            selectPaymentMethodButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        }
        
         var fields = [ValidationData]()
        
        if pickUpTime == 2 {
            var pickupFields = [ValidationData]()
            pickupFields.append(ValidationData(value: pickDateTextfield.text!, name: "Pickup Date", type: "required"))
            pickupFields.append(ValidationData(value: pickTimeTextfield.text!, name: "Pickup Time", type: "required"))
            
            if !Validation.instance.SetValidation(ValidationData: pickupFields) {
                colorAlert(textfield: pickDateTextfield)
                colorAlert(textfield: pickTimeTextfield)
                return false
            }
            
        }
        
        if requestOptions == 2 {
            var requestOptionsFields = [ValidationData]()
            requestOptionsFields.append(ValidationData(value: anotherPersonPhoneNumberTextfield.text!, name: "Phone Number", type: "required|phone"))
            
            if !Validation.instance.SetValidation(ValidationData: requestOptionsFields) {
                colorAlert(textfield: anotherPersonPhoneNumberTextfield)
                return false
            }
        }
        
        
        if shipmentCollection == 1 {
            var shipmentCollectionFields = [ValidationData]()
            shipmentCollectionFields.append(ValidationData(value: shipmentPriceTextfield.text!, name: "Shipment Price", type: "required"))
            if !Validation.instance.SetValidation(ValidationData: shipmentCollectionFields) {
                colorAlert(textfield: shipmentPriceTextfield)
                return false
            }
        }
        
        if pickupLocationId == nil {
            selectPickupLocationButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            return false
        }
        
        if destinationAddressId == nil {
            selectDestinationButtonOutlet.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            recipientNameTextfield.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            recipientPhoneTextfield.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            return false
        }
        
        if cityType == .international {
            var shipmentPriceField = [ValidationData]()
            shipmentPriceField.append(ValidationData(value: shipmentPriceTextfield.text!, name: "Shipment Price", type: "required"))
            if !Validation.instance.SetValidation(ValidationData: shipmentPriceField) {
                shipmentPriceTextfield.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            }
        }
        
        var descriptionField = [ValidationData]()
         descriptionField.append(ValidationData(value: shipmentDescriptionTextView.text!, name: "Description", type: "required"))
        
        if !Validation.instance.SetValidation(ValidationData: descriptionField) {
            shipmentDescriptionTextView.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            return false
        }
        
        var recipientNameField = [ValidationData]()
        recipientNameField.append(ValidationData(value: recipientNameTextfield.text!, name: "Recipient Name", type: "required"))
        if !Validation.instance.SetValidation(ValidationData: recipientNameField) {
            colorAlert(textfield: recipientNameTextfield)
            return false
        }
        
        var recipientPhoneField = [ValidationData]()
        recipientNameField.append(ValidationData(value: recipientPhoneTextfield.text!, name: "Recipient Phone", type: "required|phone"))
        if !Validation.instance.SetValidation(ValidationData: recipientPhoneField) {
            colorAlert(textfield: recipientPhoneTextfield)
            return false
        }
        
        return Validation.instance.SetValidation(ValidationData: fields)
    }
    
}

extension CompleteOrderTableVC: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Wornkingisjf")
        textField.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Wornkingisjf")
        textView.layer.borderColor = #colorLiteral(red: 0.4470588235, green: 0.8156862745, blue: 0.9215686275, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.borderColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        let newLength = textView.text.characters.count
//        descriptionCharCounter.text = "\(newLength)"
//        return textView.text.characters.count + (text.characters.count - range.length) <= 200
//    }
}


//MARK: - COLLECTION VIEW DELEGATE
extension CompleteOrderTableVC {
    
    //MARK: - SETTING UP HELPER FUNCTIONS
    func setupUI() {
        //Setting Delegates
        shipmentDescriptionTextView.delegate = self
        pickDateTextfield.delegate = self
        pickTimeTextfield.delegate = self
        shipmentPriceTextfield.delegate = self
        anotherPersonPhoneNumberTextfield.delegate = self
        copounTextfield.delegate = self
        
        //CollectionView Delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ShipmentImageCell", bundle: nil), forCellWithReuseIdentifier: "ShipmentImageCell")
    }
    
    func setupDateTextfield() {
        datePicker.datePickerMode = .date
        pickDateTextfield.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(userSelectedDate))
        toolbar.setItems([doneButton], animated: true)
        pickDateTextfield.inputAccessoryView = toolbar
    }
    
    @objc func userSelectedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        datePicker.minimumDate = Date()
        let newDate = formatter.string(from: datePicker.date)
        pickDateTextfield.text = "\(newDate)"
        self.view.endEditing(true)
    }
    
    func setupTimeTextfield() {
        timePicker.datePickerMode = .time
        pickTimeTextfield.inputView = timePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(userSelectedTime))
        toolbar.setItems([doneButton], animated: true)
        pickTimeTextfield.inputAccessoryView = toolbar
    }
    
    @objc func userSelectedTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let newTime = formatter.string(from: timePicker.date)
        pickTimeTextfield.text = "\(newTime)"
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemGetImages?(imagesLarge)
        return self.images.count < 3 ? images.count + 1 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShipmentImageCell", for: indexPath) as! ShipmentImageCell
        
        if indexPath.row == 0 && self.images.count < 3 {
            cell.shipmentImage.image = UIImage(named: "")
            cell.removeButton.isHidden = true
            cell.selectedShipmentImage.isHidden = false
            cell.selectedShipmentImage.image = #imageLiteral(resourceName: "add_circle - material")
        } else {
            cell.shipmentImage.image = images[self.images.count < 3 ? indexPath.row - 1 : indexPath.row]
            cell.removeButton.isHidden = false
            cell.selectedShipmentImage.isHidden = true
        }
        cell.removeButton.tag = self.images.count < 3 ? indexPath.row - 1 : indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeImage), for: .touchUpInside)
        
        return cell
    }
    
    @objc func removeImage(_ sender: UIButton) {
        if self.images.count > sender.tag {
            self.images.remove(at: sender.tag)
            self.imagesLarge.remove(at: sender.tag)
            self.imageArray.remove(at: sender.tag)
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.row < 3 {
            // Create Alet View Controller
            let alertController = alertView("")
            
            // photo Library Action
            let defaultAction = CFAlertAction(title:  "Gallery".Localize,
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
            
        } else {
            
            
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}
