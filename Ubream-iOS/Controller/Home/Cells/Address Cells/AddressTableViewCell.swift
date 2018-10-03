//
//  AddressTableViewCell.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/25/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var addressAndCityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    var locationType: LocationType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(_ data: Address, check: Bool) {
        nameLabel.text = data.name
        var address = ""
        if data.type == 2 {
            address = "\(data.latitude!), \(data.longtude!), \(data.region!.englishName!), \(data.city!.englishName!)"
        } else if data.type == 1 {
            address = "\(data.neighborhood!), \(data.region!.englishName!), \(data.city!.englishName!)"
        }
        print("address", address)
        phoneLabel.text = data.phone
        addressAndCityLabel.text = address
        countryLabel.text = data.country?.englishName
        
        if check {
            checkImage.alpha = 1
        } else {
            checkImage.alpha = 0
        }
    }
    
    
    
    
    
    
    
    
    
}
