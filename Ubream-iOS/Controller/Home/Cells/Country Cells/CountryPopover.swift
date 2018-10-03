//
//  CountryPopover.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

protocol UserDidSelectCountryProtocol {
    func getCountryId(name: String, index: Int)
}

class CountryPopover: UIViewX {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
            tableView.register(UINib(nibName: "CountryTableVCell", bundle: nil), forCellReuseIdentifier: "CountryTableVCell")
            tableView.estimatedRowHeight = UITableViewAutomaticDimension
        }
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        popover?.dismiss()
    }
    
    var countries = [Country]()
    var selectedCountry: String?
    var selectedCountryId: Int?
    var delegate: UserDidSelectCountryProtocol?
    var popover: Popover?

}

extension CountryPopover: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row].englishName
        //Delegate
        delegate?.getCountryId(name: country!, index: indexPath.row)
        popover?.dismiss()
    }
    
    
    
}


extension CountryPopover: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableVCell", for: indexPath) as? CountryTableVCell {
            if selectedCountry == countries[indexPath.row].englishName {
                cell.config(countries[indexPath.row], check: true)
            } else {
                cell.config(countries[indexPath.row], check: false)
            }
            return cell
            
        }
        return CountryTableViewCell()
    }

    
    
}
