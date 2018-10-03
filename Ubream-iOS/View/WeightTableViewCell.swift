//
//  WeightTableViewCell.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class WeightTableViewCell: UITableViewCell {

    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func config(_ data: [String], check: Bool) {
        weightLabel.text = data[0]
        print("Data is from Here!")
        if check {
            checkImage.alpha = 1
        } else {
            checkImage.alpha = 0
        }
    }

}
