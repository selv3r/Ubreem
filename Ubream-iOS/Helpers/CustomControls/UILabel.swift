//
//  UILabel.swift
//  ffexa
//
//  Created by Abdelrahman on 3/13/17.
//  Copyright © 2017 Abdelrahman. All rights reserved.
//

import UIKit

extension UILabel {
    
    func AllSizesFonts(_ FontFamily:String,Iphone4Size:Float,Iphone5Size:Float,Iphone6Size:Float,Iphone7Size:Float,Ipad9Size:Float,Ipad12Size:Float){
        var font:UIFont
        let screenHeight = UIScreen.main.bounds.height
        switch screenHeight {
        case 480:  // 3.5  inch iphone4 (s)
            font =  UIFont(name: FontFamily, size: CGFloat(Iphone4Size))!
        case 568:  // 4    inch iphone5 (c/s/se)
            font =  UIFont(name: FontFamily, size: CGFloat(Iphone5Size))!
        case 667:  // 4.7  inch iphone 6/7 (s)
            font =  UIFont(name: FontFamily, size: CGFloat(Iphone6Size))!
        case 736:  // 5.5  inch iphone 6/7 plus (s)
            font =  UIFont(name: FontFamily, size: CGFloat(Iphone7Size))!
        case 768:  // 9.7  inch ipad 6/7 plus (s)
            font =  UIFont(name: FontFamily, size: CGFloat(Ipad9Size))!
        case 1024:  // 12.9  inch ipad 6/7 plus (s)
            font =  UIFont(name: FontFamily, size: CGFloat(Ipad12Size))!
        default:  // rest of screen sizes
            font =  UIFont(name: FontFamily, size: CGFloat(Iphone4Size))!
        }
        self.font =  font
    }
    func AddConstraintForSizes(View:UIView, Iphone4: Float , Iphone5:Float , Iphone6:Float , Iphone7:Float, Ipad9: Float , Ipad12: Float) {
        let screenHeight = UIScreen.main.bounds.height
        
        switch screenHeight {
        case 480:  // 3.5  inch iphone4 (s)
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Iphone4)).isActive = true
        case 568:  // 4    inch iphone5 (c/s/se)
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Iphone5)).isActive = true
        case 667:  // 4.7  inch iphone 6/7 (s)
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Iphone6)).isActive = true
        case 736:  // 5.5  inch iphone 6/7 plus (s)
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Iphone7)).isActive = true
        case 768:  // 9.7  inch ipad 6/7 plus (s)
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Ipad9)).isActive = true
        case 1024:  // 12.9  inch ipad 6/7 plus (s)
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Ipad12)).isActive = true
        default:  // rest of screen sizes
            self.centerXAnchor.constraint(equalTo: View.centerXAnchor,  constant: CGFloat(Iphone7)).isActive = true
        }
    }
    func BorderBottom( color:UIColor , width:CGFloat)  {
        let border = CALayer()
        let width = width
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func setBottomBorder(color:UIColor , height:CGFloat) {
        self.layer.backgroundColor = UIColor.hexStringToUIColor(hex: "EBEBF1").cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSAttributedStringKey.font, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    func ConfigAttributedText(text:String) {
        let attrString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5 // change line spacing between paragraph like 36 or 48
        style.minimumLineHeight = 5 // change line spacing between each line like 30 or 40
        style.alignment = .right
//        attrString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "NeoSansArabic", size: 15)!, range: NSRange(location: 0, length: text.characters.count))
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: [text.startIndex...text.endIndex].count))
        //return attrString
        self.attributedText = attrString
    }
}

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}


extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
}

extension UILabel {
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}

