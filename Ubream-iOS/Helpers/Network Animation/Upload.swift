//
//  Upload.swift
//  Events
//
//  Created by abdelrahman on 2/5/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//
import UIKit
import Material
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

extension UIViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func presentImagePicker() {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = .photoLibrary
        ImagePicker.allowsEditing = true
        UIApplication.topViewController()?.present(ImagePicker, animated: true, completion: nil)
    }
    
    func uploaderConfig(Uploader: SVUploader)  {
        //        Uploader.borderWidth = 0
        Uploader.isHidden = false
        Uploader.SVborderWidth = 0
        Uploader.borderColor = .clear
        Uploader.SVBorderColor = .clear
        //        Uploader.lineColor = ColorConstant.red
        Uploader.circleBorderLayer.lineWidth = 3
        //        Uploader.circleBorderLayer.fillColor = ColorConstant.red.cgColor
        Uploader.startUpload()
    }
    
    
    func requestWithUploadImages(_ link:String, Myimages:[UIImage], MyimageName:String ,parameters:[String: Any] ,method:HTTPMethod , completion: @escaping (JSON) -> ()) {
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            // parametiers
            parameters.forEach({ (key,value) in
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            })
            var num = 1
            print("images count====>", Myimages.count)
            Myimages.forEach({ (Myimage) in
                if (UIImageJPEGRepresentation(Myimage, 1.0) as Data?) != nil{
                    multipartFormData.append((UIImageJPEGRepresentation(Myimage, 1.0) as Data?)!, withName: MyimageName, fileName: "Image\(num).jpg", mimeType: "image/jpg")
                    num += 1
                }
                
            })
            
        }, to: link, method: method , headers: ["Content-Type": "application/json","Accept": "application/json"], encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress { progress in // main queue by default
                    // Start the upload
                    print("Upload Progress: \(progress.fractionCompleted)")
                    NVActivityIndicatorPresenter.sharedInstance.setMessage("Upload Progress: \( Int(progress.fractionCompleted * 100) )%")
                    
                    // Update the progress in your update code
                }
                upload.responseJSON { response in
                    print(response)
                    switch response.result {
                    case .success:
                        if let data = response.result.value{
                            let json = JSON(data)
                            if json["error"].string == "Unauthenticated."{
                                //                                UIApplication.topViewController()?.goToLogin()
                                UIApplication.topViewController()?.StopLoading()
                            }else{
                                completion(json)
                            }
                            
                        }
                    case .failure(let encodingError):
                        UIApplication.topViewController()?.view.isUserInteractionEnabled = true
                        UIApplication.topViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = true
                        UIApplication.topViewController()?.DangerAlert(message: encodingError as? String ?? "" )
                        break
                    }
                }
            case .failure(let encodingError):
                UIApplication.topViewController()?.view.isUserInteractionEnabled = true
                UIApplication.topViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = true
                UIApplication.topViewController()?.DangerAlert(message: encodingError as! String )
                break
            }
        })
    }
    
    func requestWithUploadImage(_ link:String, image:UIImage, imageName:String ,parameters:[String: Any] ,method:HTTPMethod  ,uploader:SVUploader , imageView:UIImageView, imageBtn:UIButton, completion: @escaping (JSON) -> ()) {
        if (UIImageJPEGRepresentation(image, 1.0) as Data?) != nil{
            uploader.image = image
            uploaderConfig(Uploader:uploader)
        }
        imageBtn.isUserInteractionEnabled = false
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            // parametiers
            print(parameters)
            parameters.forEach({ (key,value) in
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            })
            if (UIImageJPEGRepresentation(image, 1.0) as Data?) != nil{
                multipartFormData.append((UIImageJPEGRepresentation(image, 1.0) as Data?)!, withName: imageName, fileName: "UserImage.jpg", mimeType: "image/jpg")
            }
        }, to: link, method: method , headers: ["Accept": "application/json"], encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress { progress in // main queue by default
                    print("Upload Progress: \(progress.fractionCompleted)")
                    // Start the upload
                    if (UIImageJPEGRepresentation(image, 1.0) as Data?) != nil{
                        NVActivityIndicatorPresenter.sharedInstance.setMessage("جاري الرفع: \(String(format: "%.1f", progress.fractionCompleted * 100))%")
                    }
                    // Update the progress in your update code
                    uploader.progress = CGFloat(progress.fractionCompleted)
                }
                upload.responseJSON { response in
                    print(response)
                    switch response.result {
                    case .success:
                        if let data = response.result.value{
                            let json = JSON(data)
                            if json["error"].string == "Unauthenticated."{
                                //                                UIApplication.topViewController()?.goToLogin()
                                UIApplication.topViewController()?.StopLoading()
                            }else{
                                if (UIImageJPEGRepresentation(image, 1.0) as Data?) != nil{
                                    self.UploadTransition( Myimage:image ,uploader:uploader , imageView:imageView,status: true)
                                    
                                }
                                completion(json)
                            }
                            UIApplication.topViewController()?.view.isUserInteractionEnabled = true
                            UIApplication.topViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = true
                        }
                        imageBtn.isUserInteractionEnabled = true
                        
                    case .failure(let encodingError):
                        self.StopLoading()
                        UIApplication.topViewController()?.view.isUserInteractionEnabled = true
                        imageBtn.isUserInteractionEnabled = true
                        UIApplication.topViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = true
                        self.UploadTransition( Myimage:image ,uploader:uploader , imageView:imageView,status: false)
                        UIApplication.topViewController()?.DangerAlert(message: encodingError.localizedDescription )
                        break
                    }
                }
            case .failure(let encodingError):
                self.StopLoading()
                imageBtn.isUserInteractionEnabled = true
                UIApplication.topViewController()?.view.isUserInteractionEnabled = true
                UIApplication.topViewController()?.navigationController?.navigationBar.isUserInteractionEnabled = true
                self.UploadTransition( Myimage:image ,uploader:uploader , imageView:imageView,status: false)
                UIApplication.topViewController()?.DangerAlert(message: encodingError as! String )
                break
            }
        })
    }
    
    func UploadTransition( Myimage:UIImage ,uploader:SVUploader , imageView:UIImageView , status:Bool)  {
        UIView.animate(withDuration: 0.2, animations: {
            uploader.loadingLabel.alpha = 0
            uploader.endView.alpha = 1
        }) { (completion) in
            UIView.animate(withDuration: 1, delay: (uploader.messageDuration), options: [], animations: {
                uploader.overlayView.alpha = 0
                uploader.blurView.alpha = 0
                uploader.endView.alpha = 0
                uploader.isHidden = true
                
            }, completion: nil)
            UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: { () -> Void in
                if status == true {
                    imageView.image = Myimage
                }
            }, completion: nil)
        }
    }
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

