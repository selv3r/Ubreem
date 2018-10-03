//
//  Language.swift
//  Localization
//
//  Created by Mina Shehata Gad on 9/1/17.
//  Copyright © 2017 Mina Shehata Gad. All rights reserved.
//

import Foundation

class Language
{
    class func currentLanguage() -> String
    {
        let def = UserDefaults.standard
        let langs = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = langs.firstObject as! String
        return firstLang
    }
    class func setAppLanguage(lang:String)
    {
        let def = UserDefaults.standard
        def.set([lang, currentLanguage()], forKey: "AppleLanguages")
        def.synchronize()
    }
    
}
