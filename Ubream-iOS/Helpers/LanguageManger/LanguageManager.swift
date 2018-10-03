//
//  LanguageManager.swift
//  base
//
//  Created by abdelrahman on 6/3/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import UIKit

class LanguageManager {
    
    /// Returns the singleton LanguageManager instance.
    static let shared: LanguageManager = LanguageManager()
    
    
    /// Returns the currnet language
    var currentLanguage: Languages {
        get {
            
            guard let currentLang = UserDefaults.standard.string(forKey: "selectedLanguage") else {
                fatalError("Did you set the default language for the app ?")
            }
            return Languages(rawValue: currentLang)!
        }
        set {
            
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedLanguage")
        }
    }
    
    /// Returns the default language that the app will run first time
    var defaultLanguage: Languages {
        get {
            
            guard let defaultLanguage = UserDefaults.standard.string(forKey: "defaultLanguage") else {
                fatalError("Did you set the default language for the app ?")
            }
            return Languages(rawValue: defaultLanguage)!
        }
        set {
            
            // swizzle the awakeFromNib from nib and localize the text in the new awakeFromNib
            UIView.localize()
            
            let defaultLanguage = UserDefaults.standard.string(forKey: "defaultLanguage")
            guard defaultLanguage == nil else {
                return
            }
            
            UserDefaults.standard.set(newValue.rawValue, forKey: "defaultLanguage")
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedLanguage")
            setLanguage(language: newValue)
        }
    }
    
    
    /// Returns the diriction of the language
    var isRightToLeft: Bool {
        get {
            let lang = LanguageManager.shared.currentLanguage.rawValue
            return lang.contains("ar") || lang.contains("he") || lang.contains("ur") || lang.contains("fa")
        }
    }
    

    /// Returns the app locale for use it in dates and currency
    var appLocale: Locale {
        get {
            return Locale(identifier: currentLanguage.rawValue)
        }
    }
    
    ///
    /// Set the current language for the app
    ///
    /// - parameter language: The language that you need from the app to run with
    ///
    func setLanguage(language: Languages) {
        
        // change the dircation of the views
        DispatchQueue.main.async {
            let semanticContentAttribute:UISemanticContentAttribute = language == .ar ? .forceRightToLeft : .forceLeftToRight
            UIView.appearance().semanticContentAttribute = semanticContentAttribute
            UINavigationBar.appearance().semanticContentAttribute = semanticContentAttribute
            UITextField.appearance().semanticContentAttribute = semanticContentAttribute
            UITextView.appearance().semanticContentAttribute = semanticContentAttribute
            
            // change app language
            Bundle.setLanguageForViewsLocalization(language.rawValue)
            UserDefaults.standard.set([language.rawValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }

        
        // set current language
        currentLanguage = language
    }
}

enum Languages:String {
    case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he
    case enGB = "en-GB"
    case enAU = "en-AU"
    case enCA = "en-CA"
    case enIN = "en-IN"
    case frCA = "fr-CA"
    case esMX = "es-MX"
    case ptBR = "pt-BR"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case zhHK = "zh-HK"
}


// MARK: Swizzling
extension UIView {
    static func localize() {
        
        let orginalSelector = #selector(awakeFromNib)
        let swizzledSelector = #selector(swizzledAwakeFromNib)
        
        let orginalMethod = class_getInstanceMethod(self, orginalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod!), method_getTypeEncoding(orginalMethod!))
        } else {
            method_exchangeImplementations(orginalMethod!, swizzledMethod!)
        }
        
    }
    
    @objc func swizzledAwakeFromNib() {
        swizzledAwakeFromNib()
        
        switch self {
        case let txtf as UITextField:
            txtf.text = txtf.text?.localiz()
        case let lbl as UILabel:
            lbl.text = lbl.text?.localiz()
        case let btn as UIButton:
            btn.setTitle(btn.title(for: .normal)?.localiz(), for: .normal)
        default:
            break
        }
    }
}


// MARK: String extension
extension String {
    
    ///
    /// Localize the current string to the selected language
    ///
    /// - returns: The localized string
    ///
    func localiz() -> String {
        guard let bundle = Bundle.main.path(forResource: LanguageManager.shared.currentLanguage.rawValue, ofType: "lproj") else {
            return NSLocalizedString(self, comment: "")
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: "")
    }

    var locale: String {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }
    
}

// MARK: UIApplication extension
extension UIApplication {
    // Get top view controller
    static var topViewController:UIViewController? {
        get{
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }else{
                return nil
            }
        }
    }
    
}
