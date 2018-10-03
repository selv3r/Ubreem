//
//  UIImageView+Extension.swift
//  SnapCar-iOS
//
//  Created by Intcore on 7/16/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import Foundation
import UIKit

class CircleImage: UIImageView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Makes it a circle if it has equal width and height
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}



extension UIImageView {
    // Load and image from a given url if the imagView still exists
   @discardableResult func loadImage(url:URL) -> URLSessionDownloadTask{
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){
            [weak self] url,response,error in
            
            // Check for errors and try to get the image from the data.
            if error == nil,let url = url, let data = try? Data(contentsOf: url),let image = UIImage(data: data){
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        // Set the image if self isn't dismissed
                        strongSelf.image = image
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
