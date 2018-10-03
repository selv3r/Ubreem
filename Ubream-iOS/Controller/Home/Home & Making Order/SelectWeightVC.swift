//
//  SelectWeightVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

enum CityType {
    case insideCity
    case outsideCity
    case international
}

class SelectWeightVC: RootTableViewController, UserDidSelectWeight, UserDidSelectCountryProtocol {
    
    @IBOutlet weak var selectWeightLabel: UILabel!
    @IBOutlet weak var selectCountryLabel: UILabel!
    
    @IBOutlet weak var selectWeightButton: UIButtonX!
    @IBOutlet weak var selectCountryButton: UIButtonX!
    
    var weightName: String?
    var weightId: Int = -1
    
    var weightString: String?
    var price: String?
    var pricePerKg: String?

    var countries: [Country] = []
//    var countryName: String?
//    var countryId: Int?
    
    var cityType: CityType?
    
    var popover = Popover()
    
    //Inside City
    var insideWeights: [String]? = []
    //Outside City
    var outsideWeights: [String]? = []
    
    //International
    var countryName: String?
    var countryId: Int = -1
    var selectedCountry: String?
    var selectedCountryId: Int = -1
    
    var weights: [String]? = []
    var data: OrderData?
    
    var hint: String?
    var timePerDelivery: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        title = "Item Weight"
    }
    
    @IBAction func selectCountryButtonPressed(_ sender: Any) {
        view.endEditing(true)
        if let countryPopover = Bundle.main.loadNibNamed("CountryPopover", owner: nil, options: nil)?.first as? CountryPopover {
            popover = Popover()
            countryPopover.popover = popover
            countryPopover.delegate = self
            countryPopover.countries = self.countries
            countryPopover.selectedCountry = selectedCountry
            countryPopover.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 220)
            popover.show(countryPopover, fromView: selectCountryButton)
        }
    }
    
    @IBAction func selectWeightButtonPressed(_ sender: Any) {
        view.endEditing(true)
        if let weightPopup = Bundle.main.loadNibNamed("WeightPopover", owner: nil, options: nil)?.first as? WeightPopover {
            popover = Popover()
            weightPopup.popover = popover
            weightPopup.delegate = self
            weightPopup.selectedWeight = weightString
            if cityType == .insideCity {
                weightPopup.weights = self.insideWeights!
            } else if cityType == .outsideCity {
                weightPopup.weights = self.outsideWeights!
            } else {
                if countryId == 0 {
                    print(countryId)
                    self.DangerAlert(message: "Please Select Country First!")
                } else {
                    print("Country ID: \(countryId)")
                    self.weights = []
                    let selectedCountry = data?.internationalWeights![selectedCountryId]
                    print(selectedCountry?.arabicName)
                    let weightsArray = selectedCountry?.weights
                    if (weightsArray?.count)! > 0 {
                        for weight in weightsArray! {
                            self.weights?.append(weight.weight!)
                        }
                    }
                }
                weightPopup.weights = self.weights!
            }
            weightPopup.frame = CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 220)
            popover.show(weightPopup, fromView: selectWeightButton)
        }
    }
    
    @IBAction func saveWeightButtonPressed(_ sender: Any) {
        selectCountryButton.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        selectWeightButton.layer.borderColor = ColorConstant.textFieldBorder.cgColor
        if cityType == .insideCity {
            if validation() {
                let completeOrderVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CompleteOrderTableVC") as! CompleteOrderTableVC
                completeOrderVC.shipmentDestination = 1
                completeOrderVC.selectedWeight = weightString
                completeOrderVC.selectedWeightPrice = price
                completeOrderVC.cityType = .insideCity
                self.navigationController?.pushViewController(completeOrderVC, animated: true)
            }
        } else if cityType == .outsideCity {
            if validation() {
                let completeOrderVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CompleteOrderTableVC") as! CompleteOrderTableVC
                completeOrderVC.shipmentDestination = 1
                completeOrderVC.selectedWeight = weightString
                completeOrderVC.selectedWeightPrice = price
                completeOrderVC.cityType = .outsideCity
                self.navigationController?.pushViewController(completeOrderVC, animated: true)
            }
        } else {
            if validation() {
                let completeOrderVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CompleteOrderTableVC") as! CompleteOrderTableVC
                completeOrderVC.shipmentDestination = 1
                completeOrderVC.selectedWeight = weightString
                completeOrderVC.selectedWeightPrice = price
                completeOrderVC.cityType = .international
                self.navigationController?.pushViewController(completeOrderVC, animated: true)
            }
        }
    }
    
    func validation() -> Bool {
        
        if cityType == .international {
            if selectedCountryId == -1 {
                selectCountryButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            }
        }
        
        if selectWeightLabel.text == "" || selectWeightLabel.text == "Select Item Weight" {
            selectWeightButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
            return false
        }
        return true
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = ColorConstant.mainColor
        self.navigationController?.navigationBar.tintColor = ColorConstant.mainColor
        self.navigationController?.navigationBar.topItem?.title = "Item Weight"
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]
    }
    
    
    func loadData() {
        self.countries = []
        self.insideWeights = []
        self.outsideWeights = []

        StartLoading()
        API.shared.getRequiredDataToMakeOrder(apiToken: (SavedUser.loadUser()?.apiToken)!) { (orderData, success, error) in
            self.StopLoading()
            self.data = orderData
            if self.cityType == .insideCity {
                let arrayOfInsideWeights = orderData?.insideWeight?.weights
                self.insideWeights = []
                self.price = orderData?.insideWeight?.price
                for weight in arrayOfInsideWeights! {
                    print(weight)
                    self.insideWeights?.append(weight)
                }
                
            }
            if self.cityType == .outsideCity {
                let arrayOfOutsideWeights = orderData?.outsideWeight?.weights
                self.outsideWeights = []
                self.price = orderData?.outsideWeight?.price
                for weight in arrayOfOutsideWeights! {
                    self.outsideWeights?.append(weight)
                }
            } else {
                let arrayOfCountries = orderData?.countries
                print("International Countries: ", arrayOfCountries)
                self.countries = arrayOfCountries!
            }
        }
        
    }
    
    
    //MARK: - DATA FROM OTHER DELEGATES
    func weightSelected(weight: String, id: Int) {
        weightString = weight
        selectWeightLabel.text = weight
        weightId = id
        if cityType == .international {
            price = data?.internationalWeights![selectedCountryId].weights![weightId].price
            print("PRICE: \(price)")
        }
        print("Weight ID: ", weightId)
    }
    
    
    func getCountryId(name: String, index: Int) {
        if name == "" || name == "Select Country" {
            selectCountryLabel.text = "Select Country"
            countryName = ""
            countryId = -1
            selectedCountryId = -1
            selectedCountry = "Select Country"
            selectWeightLabel.text = "Select Item Weight"
            weightId = -1
            weightString = ""
        } else {
            selectCountryLabel.text = name
            countryName = name
            selectedCountryId = index
            countryId = countries[selectedCountryId].id!
            weightString = ""
            selectWeightLabel.text = "Select Item Weight"
            weightId = -1
        }
    

    }
    
}


extension SelectWeightVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }
        if indexPath.row == 1 {
            if cityType == .international {
                return 90
            } else {
                return 0
            }
        }
        if indexPath.row == 2 {
            return 90
        }
        if indexPath.row == 3 {
            return 60
        }
        return 90
    }
}
