//
//  SelectCityTableViewController.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

protocol UserDidSelectCity {
    func getCityId(name: String, index: Int)
}

class SelectCityTableViewController: UITableViewController {
    
    var protocolType: UserDidSelectCity?
    var cities: [City] = []
    var cityName: String?
    var cityId: Int?
    var selectedCityIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell {
            if cityName == cities[indexPath.row].englishName {
                cell.config(cities[indexPath.row], check: true)
            } else {
                cell.config(cities[indexPath.row], check: false)
            }
                return cell
        }
        return CityTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCityIndex = indexPath.row
        cityId = cities[indexPath.row].id
        cityName = cities[indexPath.row].englishName
        
        
        print("Selected City Id: \(cityName)")
        protocolType?.getCityId(name: cityName ?? "", index: cityId ?? 0)
        tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }

}


extension SelectCityTableViewController {
    
    func setupUI(){
        
        if Language.currentLanguage() == "en-US" {
            print("FUCK FUCK FUCK")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
            closeButtonToNavigation()
        } else {
            print("SHIT SHIT SHIT")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left - material"), style: .plain, target: self, action: #selector(backToLogin))
            closeButtonToNavigationR()
        }
        
        //self.prepareAppFont("AvenirNext")
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        title = "Select your City".Localize
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_right - material") , style: .plain, target: self, action: #selector(backToLogin))
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















