//
//  UIView+Extension.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 6/7/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


@IBDesignable
extension UIView {
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.backgroundColor = UIColor.green.cgColor
        self.layer.mask = rectShape
        
    }
    
    @IBInspectable var setRightCorners: CGFloat {
        get {
            return  0
        }
        set {
            if #available(iOS 11.0, *){
                self.clipsToBounds = false
                self.layer.cornerRadius = newValue
                if LanguageManager.shared.isRightToLeft {
                    self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
                }else{
                    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                }
            }else{
                if LanguageManager.shared.isRightToLeft {
                    roundCorners([.topLeft , .bottomLeft], radius: newValue)
                }else{
                    roundCorners([.topRight , .bottomRight], radius: newValue)
                }
            }
        }
    }
    
    @IBInspectable var setLeftCorners: CGFloat {
        get {
            return  0
        }
        set {
            if newValue != 0 {
                if #available(iOS 11.0, *){
                    self.clipsToBounds = false
                    self.layer.cornerRadius = newValue
                    if LanguageManager.shared.isRightToLeft {
                        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                    }else{
                        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
                    }
                }else{
                    if LanguageManager.shared.isRightToLeft {
                        roundCorners([.topRight , .bottomRight], radius: newValue)
                    }else{
                        roundCorners([.topLeft , .bottomLeft], radius: newValue)
                    }
                }
            }
        }
    }
    
    @IBInspectable var setBorderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    
    @IBInspectable var setBorderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow(shadowColor:UIColor.black.cgColor )
            }
        }
    }
    
    @IBInspectable var setCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var SetShadowColor: UIColor {
        get {
            return .black
        }
        set {
            self.addShadow(shadowColor: newValue.cgColor )
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 2),
                   shadowOpacity: Float = 0.3,
                   shadowRadius: CGFloat = 4.0) {
        self.layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    

}

extension UITableViewCell {
    // thumbnail image for video
    func thumbnailImageViewForUrl(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let thumbnail = try imageGenerator.copyCGImage(at: CMTime(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnail)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        return img
    }
    
}



