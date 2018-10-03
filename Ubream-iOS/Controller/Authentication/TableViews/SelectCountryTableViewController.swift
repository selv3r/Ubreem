//
//  SelectCountryTableViewController.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import DGActivityIndicatorView

protocol UserDidSelectCountry {
    func getCountryId(name: String, index: Int, clearCityId: Int)
}

class SelectCountryTableViewController: UITableViewController {
    
    //Variables
    var countries: [Country] = []
    var countryName: String?
    var countryId: Int?
    var selectedCountryIndex: Int?
    var protocolType: UserDidSelectCountry?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Countries Count: \(countries.count)")
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell {
            if countryName == countries[indexPath.row].englishName {
                cell.config(countries[indexPath.row], check: true)
            } else {
                cell.config(countries[indexPath.row], check: false)
            }
            return cell
            
        }
        return CountryTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountryIndex = indexPath.row
        countryId = countries[indexPath.row].id
        countryName = countries[indexPath.row].englishName
        
        print("Selected City Id: \(countryName)")
        tableView.reloadData()
        protocolType?.getCountryId(name: countryName ?? "", index: countryId ?? 0, clearCityId: 0)
        self.navigationController?.popViewController(animated: true)
        print("Table Dismissed!")
        
    }
    
}


extension SelectCountryTableViewController {
    
    func setupUI() {
        
        if Language.currentLanguage() == "en-US" {
            print("FUCK FUCK FUCK")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left - material"), style: .plain, target: self, action: #selector(backToLogin))
            
            closeButtonToNavigation()
        } else {
            print("SHIT SHIT SHIT")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
            closeButtonToNavigationR()
        }
        
        //self.prepareAppFont("AvenirNext")
        self.navigationItem.setHidesBackButton(true, animated: false)
        title = "Select your Country".Localize
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
    }

    
    
    func closeButtonToNavigation(){
        let rightAddBarButtonItemImage:UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
        self.navigationItem.setRightBarButton(rightAddBarButtonItemImage, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func closeButtonToNavigationR(){
        let rightAddBarButtonItemImage:UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
        self.navigationItem.setRightBarButton(rightAddBarButtonItemImage, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    @objc func backToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
}
