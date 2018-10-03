//
//  UIFont.swift
//  ETS
//
//  Created by abdelrahman on 12/4/17.
//  Copyright © 2017 abdelrahman. All rights reserved.
//
import UIKit

extension UIViewController{
    
    func prepareAppFont(_ name: String) {
        UILabel.appearance().substituteFontName = name
        UIButton.appearance().substituteFontName = name
        UITextView.appearance().substituteFontName = name
        UITextField.appearance().substituteFontName = name
    }
}

extension UILabel {
    
    @objc dynamic var substituteFontName: String? {
        get { return self.font.fontName }
        set {
            let fontNameToTest = self.font.fontName
            let sizeOfOldFont = self.font.pointSize
            var fontNameOfNewFont = ""
            if fontNameToTest.range(of: "Bold") != nil || fontNameToTest.range(of: "Heavy") != nil {
                fontNameOfNewFont += "-Bold" ;
            } else if fontNameToTest.range(of: "Semibold") != nil || fontNameToTest.range(of: "Md") != nil{
                fontNameOfNewFont +=  "-Light" ;
            } else if fontNameToTest.range(of: "medium") != nil || fontNameToTest.range(of: "Md") != nil{
                fontNameOfNewFont +=  "-Light" ;
            } else if fontNameToTest.range(of: "light") != nil {
                fontNameOfNewFont +=  "-Light" ;
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontNameOfNewFont +=  "-Light";
            }else{
                fontNameOfNewFont +=  "";
            }
            let font = "\(newValue ?? "NeoSansArabic")\(fontNameOfNewFont)"
            if self.font.fontName != "FontAwesome" {
                self.font = UIFont(name: font , size: sizeOfOldFont)
            }
  
        }
    }
}
extension UIButton{
    @objc dynamic var substituteFontName: String? {
        get { return self.titleLabel?.font.fontName }
        set {
            if let fontNameToTest = self.titleLabel?.font.fontName {
                let sizeOfOldFont = self.titleLabel?.font.pointSize
                var fontNameOfNewFont = ""
                if fontNameToTest.range(of: "Bold") != nil || fontNameToTest.range(of: "Heavy") != nil {
                    fontNameOfNewFont += "-Bold" ;
                } else if fontNameToTest.range(of: "Semibold") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "medium") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "light") != nil {
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "ultralight") != nil {
                    fontNameOfNewFont +=  "-Light";
                }else{
                    fontNameOfNewFont +=  "";
                }
                let font = "\(newValue ?? "NeoSansArabic")\(fontNameOfNewFont)"
                if self.titleLabel?.font.fontName != "FontAwesome" {
                    self.titleLabel?.font = UIFont(name: font , size: sizeOfOldFont ?? 17)
                }
            }
            
        }
    }
}

extension UITextView {
    @objc dynamic var substituteFontName: String? {
        get { return self.font?.fontName }
        set {
            if let fontNameToTest = self.font?.fontName {
                let sizeOfOldFont = self.font?.pointSize
                var fontNameOfNewFont = ""
                if fontNameToTest.range(of: "Bold") != nil || fontNameToTest.range(of: "Heavy") != nil {
                    fontNameOfNewFont += "-Bold" ;
                } else if fontNameToTest.range(of: "Semibold") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "medium") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "light") != nil {
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "ultralight") != nil {
                    fontNameOfNewFont +=  "-Light";
                }else{
                    fontNameOfNewFont +=  "";
                }
                let font = "\(newValue ?? "NeoSansArabic")\(fontNameOfNewFont)"
                if self.font?.fontName != "FontAwesome" {
                    self.font = UIFont(name: font , size: sizeOfOldFont ?? 17)
                }
            }
        }
    }
    
}

extension UITextField {
    @objc dynamic var substituteFontName: String? {
        get { return self.font?.fontName }
        set {
            if let fontNameToTest = self.font?.fontName {
                let sizeOfOldFont = self.font?.pointSize
                var fontNameOfNewFont = ""
                if fontNameToTest.range(of: "Bold") != nil || fontNameToTest.range(of: "Heavy") != nil {
                    fontNameOfNewFont += "-Bold" ;
                } else if fontNameToTest.range(of: "Semibold") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "medium") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "light") != nil {
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "ultralight") != nil {
                    fontNameOfNewFont +=  "-Light";
                }else{
                    fontNameOfNewFont +=  "";
                }
                let font = "\(newValue ?? "NeoSansArabic")\(fontNameOfNewFont)"
                if fontNameToTest != "FontAwesome" {
                    self.font = UIFont(name: font , size: sizeOfOldFont ?? 17)
                }
            }
            
        }
    }
}

