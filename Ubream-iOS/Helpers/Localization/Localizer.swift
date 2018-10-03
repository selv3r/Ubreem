//
//  Localizer.swift
//  Localization
//
//  Created by Mina Shehata Gad on 9/1/17.
//  Copyright © 2017 Mina Shehata Gad. All rights reserved.
//

import UIKit

class Localizer
{
    class func doExchange()
    {
        exchangeMethodForClass(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:))
            , overrideSelector: #selector(Bundle.customLocalizedStringForKey(forKey:value:table:)))
        
        
        exchangeMethodForClass(className: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.custom_userInterfaceLayoutDirection))
        
    }
}


extension Bundle
{
    @objc func customLocalizedStringForKey(forKey key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = Language.currentLanguage()
        var bundle = Bundle()
        
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj")
        {
            bundle = Bundle(path: path)!
        }
        else
        {
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle = Bundle(path: path!)!
        }
        
        return bundle.customLocalizedStringForKey(forKey: key, value: value, table: tableName)
        
    }
}

extension UIApplication
{
    @objc var custom_userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection
    {
        get {
            var direction = UIUserInterfaceLayoutDirection.rightToLeft
            if Language.currentLanguage() == "en-US"
            {
                direction = UIUserInterfaceLayoutDirection.leftToRight
            }
            return direction
        }
    }
}

func exchangeMethodForClass(className: AnyClass , originalSelector:Selector , overrideSelector:Selector){
    
    let originalMethod:Method = class_getInstanceMethod(className, originalSelector)!
    let overrideMehtod:Method = class_getInstanceMethod(className, overrideSelector)!
    
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMehtod), method_getTypeEncoding(overrideMehtod))
    {
        class_replaceMethod(className, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    }
    else{
        method_exchangeImplementations(originalMethod, overrideMehtod)
    }
    
    
}




