//
//  AddNewAddressVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

class AddNewAddressVC: UIViewController, UserDidSelectCountryProtocol, UserDidSelectCityProtocol, UserDidSelectRegionProtocol, UserDidSelectCoordinatesProtocol {
    
    @IBOutlet weak var nameTextfield: UITextField!

    @IBOutlet weak var countryButton: UIButtonX!
    @IBOutlet weak var cityButton: UIButtonX!
    @IBOutlet weak var regionButton: UIButtonX!
    


    //GPS OUTLETS (PICKUP)
    @IBOutlet weak var gpsView: UIView!
    @IBOutlet weak var gpsButton: UIButtonX!
    @IBOutlet weak var gpsCoordinatesLabel: UILabel!
    @IBOutlet weak var gpsLocationLabel: UILabel!
    @IBOutlet weak var gpsLocationImg: UIImageView!
    @IBOutlet weak var gpsViewHeight: NSLayoutConstraint!
    
    
    //ADDRESS OUTLETS (DESTINATION)
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextfield: UITextField!
    
    //PHONE OUTLETS (DESTINATION)
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var phoneViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    var popover: Popover?
    var countries: [Country]?
    var cities: [City]?
    var regions: [Region]?
    
    var locationType: LocationType?
    
    var selectedCountry: String?
    var selectedCity: String?
    var selectedRegion: String?
    
    var neighborhood: String?
    
    var userLatitude: String?
    var userLongtude: String?
    
    var selectedCountryId: Int = -1
    var selectedCityId: Int = -1
    var selectedRegionId: Int = -1
    var selectedCoordinateCheck: Bool = false
    
    var countryId: Int?
    var cityId: Int?
    var regionId: Int?
    var addressType: Int?
    
    var saveToUser: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
        title = "Add a New Address"
        
        if locationType == .pickup {
            addressType = 2
        } else if locationType == .destination {
            addressType = 1
        }

    }
    
    
    func setupUI() {
        if locationType == .destination {
            self.gpsView.isHidden = true
            self.gpsButton.isHidden = true
            self.gpsCoordinatesLabel.isHidden = true
            self.gpsLocationLabel.isHidden = true
            self.gpsLocationImg.isHidden = true
            self.gpsViewHeight.constant = 0.0
            if locationType == .pickup {
                neighborhood = nil
            } else if locationType == .destination {
                
            }

        } else if locationType == .pickup {
            self.addressView.isHidden = true
            self.addressLabel.isHidden = true
            self.addressTextfield.isHidden = true
            self.phoneLabel.isHidden = true
            self.phoneNumberTextfield.isHidden = true
            self.phoneViewHeight.constant = 0.0
        }
    }
    
    func loadData() {
        self.countries = []
        StartLoading()
        API.shared.getRequiredDataToCreateAddress(apiToken: (SavedUser.loadUser()?.apiToken)!) { (data, success, error) in
            self.StopLoading()
            
            let arrayOfCountries = data?.countries
            print("arrayOfCountries : \(arrayOfCountries)")
            self.countries = arrayOfCountries
        }
        
    }
    
    
    @IBAction func countryButtonPressed(_ sender: Any) {
        view.endEditing(true)
        if let countryPopup = Bundle.main.loadNibNamed("CountryPopover", owner: nil, options: nil)?.first as? CountryPopover {
            print("BUTTON PRESSED!!!!!!!!!!")
            popover = Popover()
            countryPopup.popover = popover
            countryPopup.delegate = self
            countryPopup.selectedCountry = selectedCountry
            countryPopup.countries = self.countries!
            countryPopup.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 220)
            popover?.show(countryPopup, fromView: countryButton)
        }
    }
    
    @IBAction func cityButtonPressed(_ sender: Any) {
        if selectedCountryId == -1 {
            self.DangerAlert(message: "Please Select Your Country First")
        } else {
            self.cities = []
            print("CHOOSE YOUR CITY")
            view.endEditing(true)
            let selectedCountry = countries?.filter{ $0.id == countries![selectedCountryId].id }
            print(selectedCountry)
            self.cities = selectedCountry![0].cities
            print(cities?.count)
            if let cityPopover = Bundle.main.loadNibNamed("CityPopover", owner: nil, options: nil)?.first as? CityPopover {
                print("BUTTON PRESSED!!!!!!!!!!")
                popover = Popover()
                cityPopover.popover = popover
                cityPopover.delegate = self
                cityPopover.selectedCity = selectedCity
                cityPopover.cities = self.cities!
                cityPopover.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 220)
                popover?.show(cityPopover, fromView: cityButton)
            }
        }
        
    }
    
    @IBAction func regionButtonPressed(_ sender: Any) {
        if selectedCityId == -1 {
            self.DangerAlert(message: "Please Select Your City First")
        } else {
            self.regions = []
            print("CHOOSE YOUR REGION!")
            view.endEditing(true)
            let selectedCity = cities?.filter{ $0.id == cities![selectedCityId].id }
            print(selectedCity)
            self.regions = selectedCity![0].regions
            if let regionPopover = Bundle.main.loadNibNamed("RegionPopover", owner: nil, options: nil)?.first as? RegionPopover {
                print("REGION PRESSED")
                popover = Popover()
                regionPopover.delegate = self
                regionPopover.selectedRegion = selectedRegion
                regionPopover.regions = self.regions!
                regionPopover.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 220)
                popover?.show(regionPopover, fromView: regionButton)
            }
            
        }
        
    }
    
    @IBAction func gpsButtonPressed(_ sender: Any) {
        let mapVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as? MapVC
        mapVC?.delegate = self
        self.navigationController?.pushViewController(mapVC!, animated: true)
    }
    
    
    
    @IBAction func addAddressButtonPressed(_ sender: Any) {
        
        nameTextfield.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        countryButton.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        cityButton.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        regionButton.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        gpsButton.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        
        if locationType == .pickup {
            if validation() {
                print("ADDRESS ADDED")
                StartLoading()
                let user = SavedUser.loadUser()
                API.shared.addPickupAddress(apiToken: (user?.apiToken)!, name: nameTextfield.text!, phone: (user?.phone)!, countryId: countryId!, cityId: cityId!, regionId: regionId!, type: addressType!, latitude: userLatitude!, longtude: userLongtude!, saveToUser: saveToUser) { (data, success, error) in
                    print("TRYING TO REACH")
                    if success! {
                        self.StopLoading()
                        if let data = data {
                            let address = data
                            self.SuccessAlert(message: "Address added Successfully.")
                            self.navigationController?.popViewController(animated: true)
                            print(address)
                        }
                        
                    } else {
                        self.StopLoading()
                        print("error: \(error)")
                    }
                    
                }
            }
        } else if locationType == .destination {
            if validation() {
                print("ADDRESS ADDED")
                StartLoading()
                let user = SavedUser.loadUser()
                API.shared.addDestinationAddress(apiToken: (user?.apiToken)!, name: nameTextfield.text!, phoneNumber: phoneNumberTextfield.text!, countryId: countryId!, cityId: cityId!, regionId: regionId!, type: addressType!, neighborhood: addressTextfield.text!, saveToUser: saveToUser) { (data, success, error) in
                    print("TRYING TO REACH")
                    if success! {
                        self.StopLoading()
                        if let data = data {
                            let address = data
                            self.SuccessAlert(message: "Address added Successfully.")
                            self.navigationController?.popViewController(animated: true)
                            print(address)
                        }
                        
                    } else {
                        self.StopLoading()
                        print("error: \(error)")
                    }
                }
            }
            
        }
    }
    
    
    func getCountryId(name: String, index: Int) {
        if name == "" || name == "Country" {
            selectedCountry = "Country"
            countryLabel.text = "Country"
            selectedCountryId = -1
            selectedCity = "City"
            selectedCityId = -1
            cityLabel.text = "City"
            countryLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            selectedCountry = name
            countryLabel.text = name
            selectedCountryId = index
            selectedCity = "City"
            selectedCityId = -1
            selectedRegionId = 0
            cityLabel.text = "City"
            countryId = countries![selectedCountryId].id
            countryLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            print("Name of country is \(selectedCountry) with Index \(selectedCountryId)")
        }
    }
    
    func getCityId(name: String, index: Int) {
        if name == "" || name == "City" {
            selectedCity = "City"
            cityLabel.text = "City"
            selectedRegion = "Region"
            regionLabel.text = "Region"
            selectedCityId = -1
            selectedRegionId = -1
            cityLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            selectedCity = name
            cityLabel.text = name
            selectedCityId = index
            selectedRegionId = -1
            regionLabel.text = "Region"
            selectedRegion = "Region"
            cityId = cities![selectedCityId].id
            cityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            print("Name of country is \(selectedCity) with Index \(selectedCityId)")
        }
    }
    
    func getRegionId(name: String, index: Int) {
        if name == "" || name == "Region" {
            selectedRegion = "Region"
            regionLabel.text = "Region"
            selectedRegionId = -1
            regionLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            selectedRegion = name
            regionLabel.text = name
            selectedRegionId = index
            regionId = regions![selectedRegionId].id
            regionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            print("Name of country is \(selectedRegion) with Index \(selectedRegionId)")

        }
    }
    
    
    func getUserCoordinates(lat: String, long: String) {
        if lat == "" && long == "" {
            userLatitude = ""
            userLongtude = ""
            gpsCoordinatesLabel.text = ""
            selectedCoordinateCheck = false
            gpsCoordinatesLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            userLatitude = lat
            userLongtude = long
            selectedCoordinateCheck = true
            gpsCoordinatesLabel.text = "Latitude: \(userLatitude!) & Longtude: \(userLongtude!)"
            gpsCoordinatesLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
    func validation() -> Bool {
        
        if locationType == .pickup {
            if !selectedCoordinateCheck {
                gpsButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
                return false
            }
        }
        if locationType == .destination {
            var fields = [ValidationData]()
            fields.append(ValidationData(value: phoneNumberTextfield.text!, name: "Phone Number", type: "required|phone"))
            fields.append(ValidationData(value: addressTextfield.text!, name: "Address", type: "required|min:3"))
            
            if !Validation.instance.SetValidation(ValidationData: fields) {
                colorAlert(textfield: nameTextfield)
                colorAlert(textfield: phoneNumberTextfield)
            }
        }
        
        if selectedCountryId == -1 {
            //self.DangerAlert(message: "Please Choose User Type!")
            countryButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            if selectedCityId == -1 {
                //self.DangerAlert(message: "Please Choose Your Country!")
                cityButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
                if selectedRegionId == -1 {
                    //self.DangerAlert(message: "Please Choose Your City!")
                    regionButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
                }
            }
            return false
        }
        
        if selectedCityId == -1 {
            //self.DangerAlert(message: "Please Choose Your Country!")
            cityButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            if selectedRegionId == -1 {
                regionButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            }
            return false
        }
        
        if selectedRegionId == -1 {
            //self.DangerAlert(message: "Please Choose Your City!")
            regionButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            return false
        }
        
        var fields = [ValidationData]()
        fields.append(ValidationData(value: nameTextfield.text!, name: "Name", type: "required|min:3"))
        
        if !Validation.instance.SetValidation(ValidationData: fields) {
            colorAlert(textfield: nameTextfield)
        }
        return Validation.instance.SetValidation(ValidationData: fields)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
