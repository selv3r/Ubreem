//
//  ShipmentImageCell.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/26/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit

class ShipmentImageCell: UICollectionViewCell {

    @IBOutlet weak var shipmentImage: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var selectedShipmentImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shipmentImage.layer.cornerRadius = 10
        shipmentImage.clipsToBounds = true
    }

}
