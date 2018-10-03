//
//  WeightPopover.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import Popover

protocol UserDidSelectWeight {
    func weightSelected(weight: String, id: Int)
}

class WeightPopover: UIViewX {
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 50
            tableView.register(UINib(nibName: "WeightTableViewCell", bundle: nil), forCellReuseIdentifier: "WeightTableViewCell")
            tableView.estimatedRowHeight = UITableViewAutomaticDimension
        }
    }
    
    var weights = [String]()
    
    var selectedWeight: String?
    var delegate: UserDidSelectWeight?
    var popover: Popover?
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        popover?.dismiss()
    }
}

extension WeightPopover: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weight = weights[indexPath.row]
        delegate?.weightSelected(weight: weight ?? "", id: indexPath.row ?? 0)
        popover?.dismiss()
    }
}


extension WeightPopover: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeightTableViewCell", for: indexPath) as? WeightTableViewCell {
            
            if selectedWeight == weights[indexPath.row] {
                cell.config(weights, index: indexPath.row, check: true)
            } else {
                cell.config(weights, index: indexPath.row, check: false)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}
