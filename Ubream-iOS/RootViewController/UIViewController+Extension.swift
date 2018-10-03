//
//  Validation+Ext+UIViewController.swift
//  Events
//
//  Created by abdelrahman on 1/30/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import NVActivityIndicatorView
import CFAlertViewController

extension UIViewController: UIPopoverPresentationControllerDelegate
{
    func openPickerController(with imagePicker: UIImagePickerController, sourceRect: UIButton, alertTitle: String) {
        
        actionSheet(title: alertTitle, actionTitle: "Camera".Localize, titleColor: ColorConstant.blue, actionTwoTitle: "Photo Library".Localize, actionThreeTitle: nil, actionFourTitle: nil, cancelTitle: "Cancel", completionActionOne: { (action) in
            
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                if (status == .authorized) {
                    self.displayPicker(imagePicker: imagePicker, of: .camera, mediaTypes: [kUTTypeImage as String])
                }
                if (status == .restricted) {
                    self.handleRestricted(sourceRect: sourceRect)
                }
                if (status == .denied) {
                    self.handleDenied(sourceRect: sourceRect)
                }
                if (status == .notDetermined) {
                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                        if granted {
                            self.displayPicker(imagePicker: imagePicker, of: .camera, mediaTypes: [kUTTypeImage as String])
                        }
                    })
                }
            }
        }, completionActionTwo: { (action) in
            
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
                let status = PHPhotoLibrary.authorizationStatus()
                if (status == .authorized) {
                    self.displayPicker(imagePicker: imagePicker, of: .photoLibrary, mediaTypes: [kUTTypeImage as String])
                }
                if (status == .restricted) {
                    self.handleRestricted(sourceRect: sourceRect)
                }
                if (status == .denied) {
                    self.handleDenied(sourceRect: sourceRect)
                }
                if (status == .notDetermined) {
                    PHPhotoLibrary.requestAuthorization({ (status) in
                        if status == PHAuthorizationStatus.authorized
                        {
                            self.displayPicker(imagePicker: imagePicker, of: .photoLibrary, mediaTypes: [kUTTypeImage as String])
                        }
                    })
                }
            }
        }, completionActionThree: nil, completionActionFour: nil) { (dismiss) in
            print("====== \(dismiss)")
        }
        
    }
    
    
    
    
    
    // REGULAR ALERT
//
//    func openPickerController(with imagePicker: UIImagePickerController, sourceRect: UIButton) {
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            let cameraAction = UIAlertAction(title: "Use Camera", style: .default) { (action) in
//                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//                if (status == .authorized) {
//                    self.displayPicker(imagePicker: imagePicker, of: .camera)
//                }
//                if (status == .restricted) {
//                    self.handleRestricted(sourceRect: sourceRect)
//                }
//                if (status == .denied) {
//                    self.handleDenied(sourceRect: sourceRect)
//                }
//                if (status == .notDetermined) {
//                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
//                        if granted {
//                            self.displayPicker(imagePicker: imagePicker, of: .camera)
//                        }
//                    })
//                }
//            }
//            alertController.addAction(cameraAction)
//        }
//        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
//            let photoLibraryAction = UIAlertAction(title: "Use Photo Library", style: .default) { (action) in
//                let status = PHPhotoLibrary.authorizationStatus()
//                if (status == .authorized) {
//                    self.displayPicker(imagePicker: imagePicker, of: .photoLibrary)
//                }
//                if (status == .restricted) {
//                    self.handleRestricted(sourceRect: sourceRect)
//                }
//                if (status == .denied) {
//                    self.handleDenied(sourceRect: sourceRect)
//                }
//                if (status == .notDetermined) {
//                    PHPhotoLibrary.requestAuthorization({ (status) in
//                        if status == PHAuthorizationStatus.authorized
//                        {
//                            self.displayPicker(imagePicker: imagePicker, of: .photoLibrary)
//                        }
//                    })
//                }
//            }
//            alertController.addAction(photoLibraryAction)
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alertController.addAction(cancelAction)
//        alertController.popoverPresentationController?.sourceView = sourceRect
//        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
//        present(alertController, animated: true, completion: nil)
//    }
    
    
}



extension UIViewController {
    func handleDenied(sourceRect: UIButton) {
        let alertController = UIAlertController(title: "Media Access Denied", message: "trips doesn't have access to use your device's media. please update you settings", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Go To Settings", style: .default) { (action) in
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
        alertController.popoverPresentationController?.sourceView = sourceRect
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    func handleRestricted(sourceRect: UIButton) {
        let alertController = UIAlertController(title: "Media Access Denied", message: "This device is restricted from accessing any media at this time", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
        alertController.popoverPresentationController?.sourceView = sourceRect
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    func displayPicker(imagePicker: UIImagePickerController, of type: UIImagePickerControllerSourceType, mediaTypes: [String]) {
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: type)!
        imagePicker.mediaTypes = mediaTypes // the default value is kUTTypeImage ..
        imagePicker.sourceType = type
        imagePicker.allowsEditing = true
        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
}

//
//extension UICollectionViewCell: UIDocumentPickerDelegate {
//    // REGULAR ALERT
//    //
//    func openPickerControllerForRequestConsultant(with imagePicker: UIImagePickerController, sourceRect: UIButton, alertTitle: String = "Attachments".Localize, twoAudios: Bool) {
//        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .actionSheet)
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
//                let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//                if (status == .authorized) {
//                    self.displayPicker(imagePicker: imagePicker, of: .camera, mediaTypes: [kUTTypeImage as String, kUTTypeMovie as String])
//                }
//                if (status == .restricted) {
//                    self.handleRestricted(sourceRect: sourceRect)
//                }
//                if (status == .denied) {
//                    self.handleDenied(sourceRect: sourceRect)
//                }
//                if (status == .notDetermined) {
//                    AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
//                        if granted {
//                            self.displayPicker(imagePicker: imagePicker, of: .camera, mediaTypes: [kUTTypeImage as String, kUTTypeMovie as String])
//                        }
//                    })
//                }
//            }
//            alertController.addAction(cameraAction)
//        }
//        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
//            let photoLibraryAction = UIAlertAction(title: "Photo & Video Library", style: .default) { (action) in
//                let status = PHPhotoLibrary.authorizationStatus()
//                if (status == .authorized) {
//                    self.displayPicker(imagePicker: imagePicker, of: .photoLibrary, mediaTypes: [kUTTypeImage as String, kUTTypeMovie as String])
//                }
//                if (status == .restricted) {
//                    self.handleRestricted(sourceRect: sourceRect)
//                }
//                if (status == .denied) {
//                    self.handleDenied(sourceRect: sourceRect)
//                }
//                if (status == .notDetermined) {
//                    PHPhotoLibrary.requestAuthorization({ (status) in
//                        if status == PHAuthorizationStatus.authorized
//                        {
//                            self.displayPicker(imagePicker: imagePicker, of: .photoLibrary, mediaTypes: [kUTTypeImage as String, kUTTypeMovie as String])
//                        }
//                    })
//                }
//            }
//            alertController.addAction(photoLibraryAction)
//        }
//        
////        let documentAction = UIAlertAction(title: "Document from Mobile", style: .default) { (action) in
////            let path = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
////            let fileBrowser = FileBrowser(initialPath: path)
////            fileBrowser.excludesFileExtensions = ["m4a", "mp3", "html", "jpeg", "png","jpg"]
////            fileBrowser.didSelectFile = { (file: FBFile) -> Void in
////                let data = try? Data(contentsOf: file.filePath)
////
////                UIApplication.topViewController()?.StartLoading()
////                Loader.shared.uploadData(image: nil, video: nil, pdfFile: data, audio: nil, url: URLs.uploadConsultationFile, api_token: UserModel.read(managedContext: CoreDataStack.shared.managedContext)?.api_token ?? "") { (error, json, uploaded) in
////                    if let uploaded = uploaded {
////                        print(uploaded)
////                    }
////                    if let json = json {
////                        UIApplication.topViewController()?.StopLoading()
////                        if let fileURL = json["data"].string {
////                            let thumbnailImage = self.drawPDFfromURL(url: file.filePath)!
////                            NotificationCenter.default.post(name: .attachmentAdded, object: Attachment(name: file.displayName, type: file.type.rawValue, image: thumbnailImage, url: fileURL))
////                        }
////                    }
////                }
////                print(file.displayName)
////                fileBrowser.dismiss(animated: true, completion: nil)
////            }
////            UIApplication.topViewController()?.present(fileBrowser, animated: true, completion: nil)
////        }
//        
//        let documentIcloudAction = UIAlertAction(title: "Document", style: .default) { (action) in
////
//            let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
//            documentPickerController.delegate = self
//            UIApplication.topViewController()?.present(documentPickerController, animated: true, completion: nil)
//        }
//        
//        
//        
//        // audio action
//        let audioAction = UIAlertAction(title: "Audio", style: .default) { (action) in
//            
//            if twoAudios == true {
//                UIApplication.topViewController()?.DangerAlert(message: "لا يمكن رفع اكثر من صوت")
//                return
//            }
//            let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypeMP3), String(kUTTypeAudio)], in: .import)
//            documentPickerController.delegate = self
//            
//            UIApplication.topViewController()?.present(documentPickerController, animated: true, completion: nil)
//            
////            let path = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
////            let fileBrowser = FileBrowser(initialPath: path)
////            fileBrowser.excludesFileExtensions = ["pdf", "html", "jpeg", "png","jpg"]
////            fileBrowser.didSelectFile = { (file: FBFile) -> Void in
////                let data = try? Data(contentsOf: file.filePath)
////
////                UIApplication.topViewController()?.StartLoading()
////                Loader.shared.uploadData(image: nil, video: nil, pdfFile: nil, audio: data, url: URLs.uploadConsultationFile, api_token: UserModel.read(managedContext: CoreDataStack.shared.managedContext)?.api_token ?? "") { (error, json, uploaded) in
////                    if let uploaded = uploaded {
////                        print(uploaded)
////                    }
////                    if let json = json {
////                        UIApplication.topViewController()?.StopLoading()
////                        if let fileURL = json["data"].string {
////                            NotificationCenter.default.post(name: .attachmentAdded, object: Attachment(name: file.displayName, type: "audio", image: nil, url: fileURL))
////                        }
////                    }
////                }
////                print(file.displayName)
////                fileBrowser.dismiss(animated: true, completion: nil)
////            }
////            UIApplication.topViewController()?.present(fileBrowser, animated: true, completion: nil)
//        }
//        ///////////////////////
//        alertController.addAction(audioAction)
//        alertController.addAction(documentIcloudAction)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        alertController.addAction(cancelAction)
//        alertController.popoverPresentationController?.sourceView = sourceRect
//        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
//        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
//    }
//    
//    
//    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        
//        if url.absoluteString.pathExtension == "pdf" {
//            let data = try? Data(contentsOf: url.absoluteURL)
//            UIApplication.topViewController()?.StartLoading()
//            Loader.shared.uploadData(image: nil, video: nil, pdfFile: data, audio: nil, url: URLs.uploadConsultationFile, api_token: UserModel.read(managedContext: CoreDataStack.shared.managedContext)?.api_token ?? "") { (error, json, uploaded) in
//                if let uploaded = uploaded {
//                    print(uploaded)
//                }
//                if let json = json {
//                    UIApplication.topViewController()?.StopLoading()
//                    if let fileURL = json["data"].string {
//                        let thumbnailImage = self.drawPDFfromURL(url: url) ?? UIImage()
//                        NotificationCenter.default.post(name: .attachmentAdded, object: Attachment(name: "PDF Documnet", type: "pdf", image: thumbnailImage, url: fileURL))
//                    }
//                }
//            }
//        }
//        else {
//            
//            let asset = AVURLAsset(url: url)
//            // get the time in seconds
//            let durationInSeconds = asset.duration.seconds
//            
//            if durationInSeconds <= 60 {
//                let data = try? Data(contentsOf: url.absoluteURL)
//                UIApplication.topViewController()?.StartLoading()
//                Loader.shared.uploadData(image: nil, video: nil, pdfFile: nil, audio: data, url: URLs.uploadConsultationFile, api_token: UserModel.read(managedContext: CoreDataStack.shared.managedContext)?.api_token ?? "") { (error, json, uploaded) in
//                    if let uploaded = uploaded {
//                        print(uploaded)
//                    }
//                    if let json = json {
//                        UIApplication.topViewController()?.StopLoading()
//                        if let fileURL = json["data"].string {
//                            NotificationCenter.default.post(name: .attachmentAdded, object: Attachment(name: "Audio", type: "audio", image: nil, url: fileURL))
//                        }
//                    }
//                }
//            }
//            else {
//                UIApplication.topViewController()?.DangerAlert(message: "يجب الا يتعدي مساحة الصوت دقيقة")
//            }
//        }
//        
//        controller.dismiss(animated: true, completion: nil)
//    }
//    
//    func drawPDFfromURL(url: URL) -> UIImage? {
//        guard let document = CGPDFDocument(url as CFURL) else { return nil }
//        guard let page = document.page(at: 1) else { return nil }
//        
//        let pageRect = page.getBoxRect(.mediaBox)
//        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
//        let img = renderer.image { ctx in
//            UIColor.white.set()
//            ctx.fill(pageRect)
//            
//            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
//            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
//            
//            ctx.cgContext.drawPDFPage(page)
//        }
//        return img
//    }
//    
//    
//    func handleDenied(sourceRect: UIButton) {
//        let alertController = UIAlertController(title: "Media Access Denied", message: "trips doesn't have access to use your device's media. please update you settings", preferredStyle: .alert)
//        let settingsAction = UIAlertAction(title: "Go To Settings", style: .default) { (action) in
//            DispatchQueue.main.async {
//                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
//        alertController.popoverPresentationController?.sourceView = sourceRect
//        alertController.addAction(settingsAction)
//        alertController.addAction(cancelAction)
//        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
//    }
//
//    func handleRestricted(sourceRect: UIButton) {
//        let alertController = UIAlertController(title: "Media Access Denied", message: "This device is restricted from accessing any media at this time", preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
//        alertController.popoverPresentationController?.sourceView = sourceRect
//        alertController.addAction(defaultAction)
//        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
//    }
//
//    func displayPicker(imagePicker: UIImagePickerController, of type: UIImagePickerControllerSourceType, mediaTypes: [String]) {
//        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: type)!
//        imagePicker.mediaTypes = mediaTypes // the default value is kUTTypeImage ..
//        imagePicker.sourceType = type
//        imagePicker.allowsEditing = true
//
//        DispatchQueue.main.async {
//            UIApplication.topViewController()?.present(imagePicker, animated: true, completion: nil)
//        }
//
//    }
//    
//    
//    //MARK: - Alerts with one action
//    func actionSheet(title: String, actionTitle : String, titleColor: UIColor = ColorConstant.red, actionTwoTitle: String? = nil , actionThreeTitle: String? = nil, actionFourTitle: String? = nil  ,cancelTitle: String =
//        "Cancel" , completionActionOne: @escaping (_ action: CFAlertAction) -> (), completionActionTwo: ((_ action: CFAlertAction) -> ())?, completionActionThree: ((_ action: CFAlertAction) -> ())? = nil, completionActionFour: ((_ action: CFAlertAction) -> ())? = nil, dismissCompletion: CFAlertViewController.CFAlertViewControllerDismissBlock? = nil){
//        // Create Alet View Controller
//        let alertController = alertViewController(title, titleColor: titleColor, dismissCompletion: dismissCompletion)
//        // Create first Action
//        let firstAction = defaultAlertAction(actionTitle) { (action) in
//            completionActionOne(action)
//        }
//        
//        // Create Cancel Action
//        let cancelAction = cancelAlertAction()
//        // Add Action Button Into Alert
//        alertController.addAction(firstAction)
//        
//        if let actionTwoTitle = actionTwoTitle {
//            // Create second Action
//            let secondAction = defaultAlertAction(actionTwoTitle) { (action) in
//                completionActionTwo!(action)
//            }
//            // Add Action Button Into Alert
//            alertController.addAction(secondAction)
//        }
//        
//        if let actionThreeTitle = actionThreeTitle {
//            // Create second Action
//            let thirdAction = defaultAlertAction(actionThreeTitle) { (action) in
//                completionActionThree!(action)
//            }
//            // Add Action Button Into Alert
//            alertController.addAction(thirdAction)
//        }
//        
//        if let actionFourTitle = actionFourTitle {
//            // Create second Action
//            let fourthAction = defaultAlertAction(actionFourTitle) { (action) in
//                completionActionThree!(action)
//            }
//            // Add Action Button Into Alert
//            alertController.addAction(fourthAction)
//        }
//        
//        // Add Action Button Into Alert
//        alertController.addAction(cancelAction)
//        // Present Alert View Controller
//        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
//    }
//    
//    func alertViewController(_ title: String, titleColor: UIColor = ColorConstant.red, dismissCompletion: CFAlertViewController.CFAlertViewControllerDismissBlock?) -> CFAlertViewController{
//        
//        // Create Alet View Controller
//        let alertController = CFAlertViewController(title: title,
//                                                    titleColor:  titleColor,
//                                                    message: nil,
//                                                    messageColor: nil,
//                                                    textAlignment: .center,
//                                                    preferredStyle: .actionSheet,
//                                                    headerView: nil,
//                                                    footerView: nil,
//                                                    didDismissAlertHandler:  dismissCompletion)
//        
//        return alertController
//    }
//    
//    func defaultAlertAction(_ title:String, backgroundColor:UIColor = ColorConstant.blue, completion: @escaping (_ action: CFAlertAction) -> () ) -> CFAlertAction {
//        // Create Action
//        let action = CFAlertAction(title: title,
//                                   style: .Default,
//                                   alignment: .justified,
//                                   backgroundColor: backgroundColor,
//                                   textColor: nil,
//                                   handler: { (action) in
//                                    completion(action)
//        })
//        action.backgroundColor = backgroundColor
//        return action
//    }
//    
//    func cancelAlertAction(_ title:String =
//        "Cancel".Localize) ->  CFAlertAction {
//        // Create Action
//        let action = CFAlertAction(title: title,
//                                   style: .Default,
//                                   alignment: .justified,
//                                   backgroundColor: .lightGray,
//                                   textColor: .white,
//                                   handler: nil)
//        return action
//    }
//    
//    
//    func thumbnailImageViewForUrl(url: URL) -> UIImage? {
//        let asset = AVAsset(url: url)
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        do {
//            let thumbnail = try imageGenerator.copyCGImage(at: CMTime(value: 1, timescale: 60), actualTime: nil)
//            return UIImage(cgImage: thumbnail)
//        }
//        catch {
//            print(error.localizedDescription)
//            return nil
//        }
//        return nil
//    }
//    
//    
//}
//
