//
//  UIKit+Extension.swift
//  General Project
//
//  Created by Mina Shehata Gad on 5/3/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit
import SwiftyJSON
import Lightbox
import SafariServices
import NVActivityIndicatorView
import CFAlertViewController
import BRYXBanner
import AVFoundation

//MARK:- UIViewController Extension......
extension UIViewController : NVActivityIndicatorViewable, SFSafariViewControllerDelegate {
    
    // MARK:- open safari with link
    func openLinkWithSafari(link:String)  {
        let url = URL(string: link)!
        let safariVC = SFSafariViewController(url: url)
        UIApplication.topViewController()?.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }

    func actionSheetSignleButton(title: String, actionTitle : String, titleColor: UIColor = ColorConstant.blue, dismissCompletion: CFAlertViewController.CFAlertViewControllerDismissBlock? = nil, completionActionOne: @escaping (_ action: CFAlertAction) -> ()){
        let alertController = alertViewController(title, titleColor: titleColor, dismissCompletion: dismissCompletion)
        let firstAction = defaultAlertAction(actionTitle, backgroundColor: ColorConstant.blue) { (action) in
            completionActionOne(action)
        }
        alertController.addAction(firstAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - Alerts with one action
    func actionSheet(title: String, actionTitle : String, titleColor: UIColor = ColorConstant.burble, actionTwoTitle: String? = nil , actionThreeTitle: String? = nil, actionFourTitle: String? = nil  ,cancelTitle: String =
        "Cancel".Localize , completionActionOne: @escaping (_ action: CFAlertAction) -> (), completionActionTwo: ((_ action: CFAlertAction) -> ())?, completionActionThree: ((_ action: CFAlertAction) -> ())? = nil, completionActionFour: ((_ action: CFAlertAction) -> ())? = nil, dismissCompletion: CFAlertViewController.CFAlertViewControllerDismissBlock? = nil){
        // Create Alet View Controller
        let alertController = alertViewController(title, titleColor: titleColor, dismissCompletion: dismissCompletion)
        // Create first Action
        let firstAction = defaultAlertAction(actionTitle) { (action) in
            completionActionOne(action)
        }
        
        // Create Cancel Action
        let cancelAction = cancelAlertAction()
        // Add Action Button Into Alert
        alertController.addAction(firstAction)
        
        if let actionTwoTitle = actionTwoTitle {
            // Create second Action
            let secondAction = defaultAlertAction(actionTwoTitle) { (action) in
                completionActionTwo!(action)
            }
            // Add Action Button Into Alert
            alertController.addAction(secondAction)
        }
        
        if let actionThreeTitle = actionThreeTitle {
            // Create second Action
            let thirdAction = defaultAlertAction(actionThreeTitle) { (action) in
                completionActionThree!(action)
            }
            // Add Action Button Into Alert
            alertController.addAction(thirdAction)
        }
        
        if let actionFourTitle = actionFourTitle {
            // Create second Action
            let fourthAction = defaultAlertAction(actionFourTitle) { (action) in
                completionActionThree!(action)
            }
            // Add Action Button Into Alert
            alertController.addAction(fourthAction)
        }
        
        // Add Action Button Into Alert
        alertController.addAction(cancelAction)
        // Present Alert View Controller
        present(alertController, animated: true, completion: nil)
    }
    
    func alertViewController(_ title: String, titleColor: UIColor = ColorConstant.burble, dismissCompletion: CFAlertViewController.CFAlertViewControllerDismissBlock?) -> CFAlertViewController {
        // Create Alet View Controller
        let alertController = CFAlertViewController(title: title,
                                                    titleColor:  titleColor,
                                                    message: nil,
                                                    messageColor: nil,
                                                    textAlignment: .center,
                                                    preferredStyle: .actionSheet,
                                                    headerView: nil,
                                                    footerView: nil,
                                                    didDismissAlertHandler:  dismissCompletion)
        
        return alertController
    }
    
    
    func alertWithTextField(_ title: String, headerView: UIView, titleColor: UIColor = ColorConstant.burble, dismissCompletion: CFAlertViewController.CFAlertViewControllerDismissBlock?) -> CFAlertViewController {
        // Create Alet View Controller
        let alertController = CFAlertViewController(title: title,
                                                    titleColor:  titleColor,
                                                    message: nil,
                                                    messageColor: nil,
                                                    textAlignment: .center,
                                                    preferredStyle: .alert,
                                                    headerView: headerView,
                                                    footerView: nil,
                                                    didDismissAlertHandler:  dismissCompletion)
        return alertController
    }
    
    
    func defaultAlertAction(_ title:String, backgroundColor:UIColor = ColorConstant.blue, completion: @escaping (_ action: CFAlertAction) -> () ) -> CFAlertAction {
        // Create Action
        let action = CFAlertAction(title: title,
                                   style: .Default,
                                   alignment: .justified,
                                   backgroundColor: backgroundColor,
                                   textColor: nil,
                                   handler: { (action) in
                                    completion(action)
        })
        action.backgroundColor = backgroundColor
        return action
    }
    
    func cancelAlertAction(_ title:String =
        "Cancel".Localize) ->  CFAlertAction {
        // Create Action
        let action = CFAlertAction(title: title,
                                   style: .Default,
                                   alignment: .justified,
                                   backgroundColor: .lightGray,
                                   textColor: .white,
                                   handler: nil)
        return action
    }
    
    func showCardAlert(with title: String, message: String) {
        let banner = Banner(title: title, subtitle: message, image: UIImage(named: "main_close_icon"), backgroundColor: UIViewController.successBackgroundColor)
        banner.dismissesOnTap = true
        banner.show(view, duration: 2.0)
    }

    
    /*
     * set Status bar Color
     * Color
     */
    func SetStatusBarColor(Color:UIColor)  {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = Color
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    /*
     * add keyboard hide in view
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func validationShowMessage(_ data:JSON , _ name:String) {
        if let valid = data["error"][name].arrayObject {
            UIApplication.topViewController()?.DangerAlert(message: valid[0] as! String)
        }
    }
    
    func validShowMessageAlertWithoutField(_ Data:JSON , _ name:String) {
        if let valid = Data[name].arrayObject{
            UIApplication.topViewController()?.DangerAlert(message: valid[0] as! String)
//            field.ShowAlertTextField(message: valid[0] as! String)
        }
    }
    
    
    func LogoutAlert(){
    actionSheet(title: "", actionTitle: "LogoutTitle".Localize, completionActionOne: { (action) in
            helper.goToStoryboard(with: "Authentication")
    }, completionActionTwo: nil) { (dismiss) in
            
        }
        let alert = UIAlertController(title: "LogoutTitle".Localize, message: "Logout Message".Localize, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Yes".Localize, style: UIAlertActionStyle.default,  handler: { action in
            print("yes")
            UIApplication.shared.unregisterForRemoteNotifications()
            helper.goToSignIn()
            //self.sideMenuViewController?.hideMenuViewController()
            //            Firebase registration token: d3j7mmIGL50:APA91bGZJew0KTX5Fs_7yp1NVE5eR7ZYAdT5YZqENuVKoA3F1-FqXnLWTVBZsLlonICZ5d-uRSF7qQNHUAORrUCTW4rX6h4A9ZD-2higpespz3Dvzj-7FRjMvcMaN7cS2u4LRC6Frgwc
            //            APNs device token: ab9931d7ead41eb123439e9f7568e81bc29e7b34539dd5371d93779a89cfd55e
        }))
        alert.addAction(UIAlertAction(title:"No".Localize, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func StartLoading() {
        let size = CGSize(width: 50, height: 50)
        NVActivityIndicatorView.DEFAULT_COLOR = ColorConstant.blue
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.startAnimating(size, message: "", type: NVActivityIndicatorType.ballScaleRipple)
    }
    
    func StopLoading()  {
        self.stopAnimating()
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}



//MARK:- UIViewController LightBox implementation....
extension UIViewController : LightboxControllerDismissalDelegate ,LightboxControllerPageDelegate{
    public func lightboxControllerWillDismiss(_ controller: LightboxController) {
        controller.dismiss(animated: true, completion: nil)
//        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    public func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        
    }
    
    func openImages(_ images:[String], startIndex: Int, pageIndicator: Bool = true) {
        let imgs:[LightboxImage] = images.map{LightboxImage(imageURL: URL(string: URLs.imageUrl + $0)!)}
        print(imgs)
        LightboxConfig.DeleteButton.enabled = false
        LightboxConfig.CloseButton.image = UIImage(named: "cm_close_white")
        LightboxConfig.CloseButton.text = ""
        LightboxConfig.InfoLabel.enabled = true
        LightboxConfig.PageIndicator.enabled = pageIndicator
        let lightbox = LightboxController(images: imgs , startIndex : startIndex)
        lightbox.dismissalDelegate = self
        // Set delegates.
        lightbox.pageDelegate = self
        // Use dynamic background.
        lightbox.dynamicBackground = true
        UIApplication.topViewController()?.present(lightbox, animated: true, completion: nil)
    }
    
    func openVideos(_ vedios: [String], startIndex: Int, pageIndicator: Bool = false) {
        let videos:[LightboxImage] = vedios.map{LightboxImage(image: #imageLiteral(resourceName: "cm_close_white"), text: "", videoURL: URL(string: URLs.imageUrl + $0))}
        LightboxConfig.DeleteButton.enabled = false
        LightboxConfig.CloseButton.image = #imageLiteral(resourceName: "cm_close_white")
        LightboxConfig.CloseButton.text = ""
        LightboxConfig.InfoLabel.enabled = false
        LightboxConfig.PageIndicator.enabled = pageIndicator
        let lightbox = LightboxController(images: videos , startIndex : startIndex)
        lightbox.dismissalDelegate = self
        // Set delegates.
        lightbox.pageDelegate = self
        // Use dynamic background.
        lightbox.dynamicBackground = true
        UIApplication.topViewController()?.present(lightbox, animated: true, completion: nil)
    }
}

//MARK:- UINavigationController Extension......
extension UINavigationController {
    var content: UIViewController? {
        return self.viewControllers.first
    }
}


//MARK:- UIApplication Extension......
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}


// MARK:-  Banner Alerts in UIViewController......
extension UIViewController {
    
    
    
    public static var successBackgroundColor : UIColor = ColorConstant.successAlert//UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)//UIColor(hex:"000000").withAlphaComponent(0.7)
    public static var infoBackgroundColor    : UIColor = ColorConstant.infoAlert//UIColor.green//UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)//UIColor(hex:"000000").withAlphaComponent(0.7)
    public static var warningBackgroundColor : UIColor = ColorConstant.wrongAlert//UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255,   alpha: 0.95)//UIColor(hex:"c0392b").withAlphaComponent(1)
    public static var errorBackgroundColor   : UIColor = #colorLiteral(red: 0.8774157763, green: 0.3537833691, blue: 0.04722497612, alpha: 1)//UIColor.hexStringToUIColor(hex: "c0392b").withAlphaComponent(1)
    
    func WarningAlert(_ title:String = "Warning".locale, message:String){
        let banner = Banner(title: title, subtitle: message, image: UIImage(named: "isWarningIcon"), backgroundColor: UIViewController.errorBackgroundColor)
        banner.dismissesOnTap = true
        banner.position = .bottom
        banner.minimumHeight = 120
        banner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        banner.titleLabel.topAnchor.constraint(equalTo: banner.topAnchor, constant: 20).isActive = true
        banner.titleLabel.font = UIFont(name: "NeoSansArabic", size: 20)
        banner.detailLabel.font = UIFont(name: "NeoSansArabic", size: 15)
        banner.detailLabel.numberOfLines = 2
        banner.show(duration: 2.0)
    }
    
    func colorAlert(textfield: UITextField) {
        textfield.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
    }
    
    
    func DangerAlert(_ title:String = "Wrong".locale, message:String){
        let banner = Banner(title: title, subtitle: message, image: UIImage(named: "isErrorIcon"), backgroundColor: UIViewController.errorBackgroundColor)
        banner.dismissesOnTap = true
        banner.position = .bottom
        banner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        banner.titleLabel.topAnchor.constraint(equalTo: banner.topAnchor, constant: 20).isActive = true
        banner.titleLabel.font = UIFont(name: "NeoSansArabic", size: 15)
        banner.detailLabel.font = UIFont(name: "NeoSansArabic", size: 12)
        banner.detailLabel.numberOfLines = 2
        banner.show(duration: 2.0)
    }
    
    
    
    func DangerAlertForLogin(_ title:String = "Wrong".locale, message:String){
        let alertController = self.alertViewController(message, dismissCompletion: nil)
        // Create yes Action
        let yesAction = self.defaultAlertAction("Login".locale) { (action) in
            // go to login
            helper.goToStoryboard(with: "Authentication")
        }
        
        // Create Cancel Action
        let cancelAction = self.cancelAlertAction()
        // Add Action Button Into Alert
        alertController.addAction(yesAction)
        // Add Action Button Into Alert
        alertController.addAction(cancelAction)
        // Present Alert View Controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func SuccessAlert(_ title:String = "Success".locale, message: String){
        let banner = Banner(title: title, subtitle: message, image: UIImage(named: "isSuccessIcon"), backgroundColor: UIViewController.successBackgroundColor)
        banner.dismissesOnTap = true
        banner.position = .bottom
        banner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        banner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        banner.titleLabel.topAnchor.constraint(equalTo: banner.topAnchor, constant: 20).isActive = true
        banner.titleLabel.font = UIFont(name: "NeoSansArabic", size: 20)
        banner.detailLabel.font = UIFont(name: "NeoSansArabic", size: 15)
        banner.detailLabel.numberOfLines = 2
        banner.show(duration: 2.0)
    }
    
    
    
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
//        return nil
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

//MARK:- UIDevice extension

extension UIDevice {
    static var isIphoneX: Bool {
        var modelIdentifier = ""
        if isSimulator {
            modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            modelIdentifier = String(cString: machine)
        }
        
        return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
    }
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}






