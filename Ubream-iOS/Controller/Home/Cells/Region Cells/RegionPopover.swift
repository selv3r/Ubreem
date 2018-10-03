//
//  RegionPopover.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

protocol UserDidSelectRegionProtocol {
    func getRegionId(name: String, index: Int)
}

class RegionPopover: UIViewX {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
            tableView.register(UINib(nibName: "RegionTableVCell", bundle: nil), forCellReuseIdentifier: "RegionTableVCell")
            tableView.estimatedRowHeight = UITableViewAutomaticDimension
        }
        
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        popover?.dismiss()
    }
    
    var regions = [Region]()
    var selectedRegion: String?
    var delegate: UserDidSelectRegionProtocol?
    var popover: Popover?
    
    
    
}

extension RegionPopover : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = regions[indexPath.row].englishName
        //Delegate
        delegate?.getRegionId(name: region!, index: indexPath.row)
        popover?.dismiss()
    }
    
    
    
}


extension RegionPopover: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableVCell", for: indexPath) as? RegionTableVCell {
            if selectedRegion == regions[indexPath.row].englishName {
                cell.config(regions[indexPath.row], check: true)
            } else {
                cell.config(regions[indexPath.row], check: false)
            }
            return cell
            
        }
        return CityTableVCell()
    }
    
    
    
}
