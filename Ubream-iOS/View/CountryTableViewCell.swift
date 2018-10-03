//
//  CountryTableViewCell.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func config(_ data: Country, check: Bool) {
        countryLabel.text = data.englishName
        print("Data is from Here!")
        if check {
            checkImage.alpha = 1
        } else {
            checkImage.alpha = 0
        }
    }

}
