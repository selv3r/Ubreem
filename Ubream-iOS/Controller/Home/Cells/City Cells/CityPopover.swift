//
//  RegionPopover.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

protocol UserDidSelectCityProtocol {
    func getCityId(name: String, index: Int)
}

class CityPopover: UIViewX {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
            tableView.register(UINib(nibName: "CityTableVCell", bundle: nil), forCellReuseIdentifier: "CityTableVCell")
            tableView.estimatedRowHeight = UITableViewAutomaticDimension
        }
        
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        popover?.dismiss()
    }
    
    var cities = [City]()
    var selectedCity: String?
    var delegate: UserDidSelectCityProtocol?
    var popover: Popover?
    
    
    
}

extension CityPopover: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row].englishName
        //Delegate
        delegate?.getCityId(name: city!, index: indexPath.row)
        popover?.dismiss()
    }
    
    
    
}


extension CityPopover: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableVCell", for: indexPath) as? CityTableVCell {
            if selectedCity == cities[indexPath.row].englishName {
                cell.config(cities[indexPath.row], check: true)
            } else {
                cell.config(cities[indexPath.row], check: false)
            }
            return cell
            
        }
        return CityTableVCell()
    }

    
    
}
