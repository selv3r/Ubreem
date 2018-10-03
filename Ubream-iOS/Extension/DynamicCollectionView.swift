//
//  DynamicCollectionView.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/26/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import  UIKit

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}
