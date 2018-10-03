//
//  Requests.swift
//  Events
//
//  Created by abdelrahman on 1/30/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
let imageCashe = NSCache<NSURL , UIImage>()

class Loader {
    
    // singleton object......
    static let shared = Loader()
    public var sessionManager: Alamofire.SessionManager
    public var backgroundSessionManager: Alamofire.SessionManager // your web services you intend to keep running when the system backgrounds your app will use this
    private init() {
        self.sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        self.backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.intcore.llc.SnapCar-iOS.backgroundLocation"))
    }
    
    
//    var alamoFireManager : Alamofire.SessionManager!
//
//    var backgroundCompletionHandler: (() -> Void)? {
//        get {
//            return alamoFireManager?.backgroundCompletionHandler
//        }
//        set {
//            alamoFireManager?.backgroundCompletionHandler = newValue
//        }
//    }
//
//    private init()
//    {
//        let configuration = URLSessionConfiguration.background(withIdentifier: "com.intcore.background")
//        configuration.timeoutIntervalForRequest = 200 // seconds
//        configuration.timeoutIntervalForResource = 200
//        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
//    }
    
    let headers = ["Accept": "application/json"]
    
    func request(with url:String , and method: HTTPMethod , and parameters:[String: Any] = [:] , completion: @escaping (_ data:JSON?, _ success: Bool?, _ error: JSON?) -> ()) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...422)
            .responseJSON { (response) in
                
                switch response.result {
                case .failure( _):
                    completion(nil, false, nil)
                case .success(let value):
                    let json = JSON(value)
                    if let resp = response.response {
                        if resp.statusCode == 422
                        {
                            completion(nil, false, "")
                        }
                        else
                        {
                            let data = json//["data"]
                            completion(data, true, nil)
                        }
                    }
                }
        }
    }
    
    func requestFromLoader(with url:String , and method: HTTPMethod , and parameters:[String: Any] = [:] , completion: @escaping response) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...422)
            .responseJSON { (response) in
                switch response.result {
                case .failure( _):
                    completion(nil, nil)
                case .success(let value):
                    self.parseResponse(json: JSON(value), completion: { (error, json) in
                        completion(error, json)
                    })
                }
        }
    }
    
    func requestMultipartStore(nationalId: UIImage? , vechileReg: UIImage?, drivingLicense: UIImage?, criminalRec: UIImage?, url: String , method: HTTPMethod ,parameters:[String: Any] = [:] , completion: @escaping (_ data:JSON?, _ success: Bool?, _ error: JSON?, _ uploaded: Double?) -> ()) {
        
        Alamofire.upload(multipartFormData: { (form :MultipartFormData) in
            for (key, value) in parameters
            {
                if value is Int {
                    form.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "city_id")
                } else {
                    form.append((value as! String).data(using: .utf8)!, withName: key)
                }
            }
            
            if let image = nationalId, let  data = UIImageJPEGRepresentation(image, 0.5)
            {
                form.append(data, withName: "national_identity", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
            if let image = vechileReg, let  data = UIImageJPEGRepresentation(image, 0.5)
            {
                form.append(data, withName: "vehicle_registration", fileName: "image.jpg", mimeType: "image/jpg")
            }
            if let image = drivingLicense, let data = UIImageJPEGRepresentation(image, 0.5) {
                form.append(data, withName: "driving_license", fileName: "image.jpg", mimeType: "image/jpg")
            }
            if let image = criminalRec, let data = UIImageJPEGRepresentation(image, 0.5) {
                form.append(data, withName: "clearance_criminal", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
            
            switch result {
            case .success(let upload, _, _):
                if let _ = nationalId {
                    upload.uploadProgress(closure: { (progress: Progress) in
                        let uploadedMB = progress.fractionCompleted
                        completion(nil, nil, nil, uploadedMB)
                    })
                }
                upload.validate(statusCode: 200...422)
                upload.responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        print(error.localizedDescription)
                        UIApplication.topViewController()?.DangerAlert(message: "Connection Error".Localize)
                        UIApplication.topViewController()?.StopLoading()
                        completion(nil, false, nil, nil)
                    case .success(let value):
                        let json = JSON(value)
                        if let resp = response.response {
                            if resp.statusCode == 422
                            {
                                completion(nil, false, json, nil)
                            }
                            else
                            {
                                let data = json//["data"]
                                completion(data, true, nil, nil)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, false, nil, nil)
                // end
            }
        }
    }
    
    
    func backgroundRequest(with url:String , and method: HTTPMethod , and parameters:[String: Any] = [:] , completion: @escaping response) {
        Loader.shared.backgroundSessionManager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...422)
            .responseJSON { (response) in
                switch response.result {
                case .failure( _):
                    completion(nil, nil)
                case .success(let value):
                    self.parseResponse(json: JSON(value), completion: { (error, json) in
                        completion(error, json)
                    })
                }
        }
    }
    
    func requestMultipart(photo: UIImage?, url: String , method: HTTPMethod ,parameters:[String: Any] = [:] , completion: @escaping (_ data:JSON?, _ success: Bool?, _ error: JSON?, _ uploaded: Double?) -> ()) {
        
        Alamofire.upload(multipartFormData: { (form :MultipartFormData) in
            for (key, value) in parameters
            {
                form.append((value as! String).data(using: .utf8)!, withName: key)
            }
            
            if let image = photo, let  data = UIImageJPEGRepresentation(image, 0.5)
            {
                form.append(data, withName: "file", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
            
            switch result {
            case .success(let upload, _, _):
                if let _ = photo {
                    upload.uploadProgress(closure: { (progress: Progress) in
                        let uploadedMB = progress.fractionCompleted
                        completion(nil, nil, nil, uploadedMB)
                    })
                }
                upload.validate(statusCode: 200...422)
                upload.responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        print(error.localizedDescription)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            UIApplication.topViewController()?.DangerAlert(message: "Connection Error".Localize)
                            UIApplication.topViewController()?.StopLoading()
                        }
                        
                        completion(nil, false, nil, nil)
                    case .success(let value):
                        let json = JSON(value)
                        if let resp = response.response {
                            if resp.statusCode == 422
                            {
                                completion(nil, false, json, nil)
                            }
                            else
                            {
                                let data = json//["data"]
                                completion(data, true, nil, nil)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, false, nil, nil)
                // end
            }
        }
    }
    
//    func requestMultipart(photo: UIImage?, url: String , method: HTTPMethod ,parameters:[String: Any] = [:] , completion: @escaping responseUpload) {
//
//        guard let window = UIApplication.shared.keyWindow else { return }
//        window.addSubview(uploadLabelCount)
//        uploadLabelCount.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
//        uploadLabelCount.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 80).isActive = true
//
//        Alamofire.upload(multipartFormData: { (form :MultipartFormData) in
//            for (key, value) in parameters
//            {
//                form.append((value as! String).data(using: .utf8)!, withName: key)
//            }
//            if let image = photo, let  data = UIImageJPEGRepresentation(image, 0.5)
//            {
//                form.append(data, withName: "file", fileName: "image.jpg", mimeType: "image/jpg")
//            }
//        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
//
//            switch result {
//            case .success(let upload, _, _):
//                if let _ = photo {
//                    upload.uploadProgress(closure: { (progress: Progress) in
//                        let uploadedMB = progress.fractionCompleted * 100
//                        self.uploadLabelCount.text = String(format: "%0.1f Uploaded", uploadedMB)
//                        print("=============\(uploadedMB)******")
//
//                        completion(nil, nil, uploadedMB)
//                    })
//                }
//                upload.validate(statusCode: 200...422)
//                upload.responseJSON { response in
//                    switch response.result {
//                    case .failure(let error):
//                        UIApplication.topViewController()?.DangerAlert(message: "upload failed , please try again")
//                        UIApplication.topViewController()?.StopLoading()
//                        self.uploadLabelCount.removeFromSuperview()
//                        print(error.localizedDescription)
//                        completion(nil, nil, nil)
//                    case .success(let value):
//                        self.uploadLabelCount.removeFromSuperview()
//                        self.parseResponse(json: JSON(value), completion: { (error, json) in
//                            completion(error, json, nil)
//                        })
//                    }
//                }
//            case .failure(let error):
//                UIApplication.topViewController()?.DangerAlert(message: "upload failed , please try again")
//                UIApplication.topViewController()?.StopLoading()
//                print(error.localizedDescription)
//                completion(nil, nil, nil)
//                // end
//            }
//        }
//    }
    
    func requestAttachMultipart(photo: UIImage?, url: String , method: HTTPMethod ,parameters:[String: Any] = [:] , completion: @escaping responseUpload) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(uploadLabelCount)
        
        uploadLabelCount.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        uploadLabelCount.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 80).isActive = true
        
        Alamofire.upload(multipartFormData: { (form :MultipartFormData) in
            for (key, value) in parameters
            {
                form.append((value as! String).data(using: .utf8)!, withName: key)
            }
            if let image = photo, let  data = UIImageJPEGRepresentation(image, 0.5)
            {
                form.append(data, withName: "attachment", fileName: "image.jpg", mimeType: "image/jpg")
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
            
            switch result {
            case .success(let upload, _, _):
                if let _ = photo {
                    upload.uploadProgress(closure: { (progress: Progress) in
                        let uploadedMB = progress.fractionCompleted * 100
                        self.uploadLabelCount.text = String(format: "%0.1f Uploaded", uploadedMB)
                        print("=============\(uploadedMB)******")
                        
                        completion(nil, nil, uploadedMB)
                    })
                }
                upload.validate(statusCode: 200...422)
                upload.responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        UIApplication.topViewController()?.DangerAlert(message: "upload failed , please try again")
                        UIApplication.topViewController()?.StopLoading()
                        self.uploadLabelCount.removeFromSuperview()
                        print(error.localizedDescription)
                        completion(nil, nil, nil)
                    case .success(let value):
                        self.uploadLabelCount.removeFromSuperview()
                        self.parseResponse(json: JSON(value), completion: { (error, json) in
                            completion(error, json, nil)
                        })
                    }
                }
            case .failure(let error):
                UIApplication.topViewController()?.DangerAlert(message: "upload failed , please try again")
                UIApplication.topViewController()?.StopLoading()
                print(error.localizedDescription)
                completion(nil, nil, nil)
                // end
            }
        }
    }
    
    
    func downloadImage(with imageView: UIImageViewX, and imageURL: String) {
        let url = URL(string: URLs.imageUrl + imageURL)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
    func downloadThumbImage(with imageView: UIImageViewX, and imageURL: String) {
        let url = URL(string:  imageURL)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
    
    func getImage(url: String) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: URLs.imageUrl + url)!)
        return imageView.image
    }
    
    func getMapImage(gender: Int?, _ isVIP: Bool = false, title : String = "", url: String, completion: @escaping (_ icon: UIView?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
           let data = try? Data(contentsOf: URL(string: URLs.imageUrl + url)!)
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    let view = UIViewX(frame: CGRect(x: 0, y: 0, width: 80, height: 95))
                    view.backgroundColor = .clear
                    let vipImageView = UIImageViewX(frame: CGRect(x: 30, y: 0, width: 20, height: 20))
                    view.addSubview(vipImageView)
                    let labelView = UIView(frame: CGRect(x: 0, y: 20, width: 80, height: 25))
                    let label = UILabel(frame: CGRect(x: 5, y: 0, width: 70, height: 25))
                    labelView.addSubview(label)
                    label.text = title
                    label.textAlignment = .center
                    labelView.backgroundColor = .white
                    labelView.layer.cornerRadius = 5
                    labelView.layer.masksToBounds = true
                    if isVIP {
                        vipImageView.image = #imageLiteral(resourceName: "vip_stamp")
                        labelView.layer.borderColor = UIColor.red.cgColor
                    }
                    else
                    {
                        vipImageView.image = nil
                        labelView.layer.borderColor = UIColor.lightGray.cgColor
                    }
                    labelView.layer.borderWidth = 1
                    label.font = UIFont.systemFont(ofSize: 10)
                    view.addSubview(labelView)
                    let imageView = UIImageViewX(frame: CGRect(x: 20, y: 45, width: 40, height: 40))
                    imageView.contentMode = .scaleAspectFill
                    view.addSubview(imageView)
                    
                    if isVIP {
                        imageView.layer.borderColor = UIColor.red.cgColor
                    }
                    else {
                        imageView.layer.borderColor = UIColor.lightGray.cgColor
                    }

                    if let gender = gender, gender == 2 {
                        labelView.layer.borderColor = UIColor.purple.cgColor
                        imageView.layer.borderColor = UIColor.purple.cgColor
                    }
                    if let gender = gender, gender == 1 {
                        labelView.layer.borderColor = UIColor.green.cgColor
                        imageView.layer.borderColor = UIColor.green.cgColor
                    }
                    if let gender = gender, gender == 3 {
                        labelView.layer.borderColor = ColorConstant.blue.cgColor
                        imageView.layer.borderColor = ColorConstant.blue.cgColor
                    }
                    imageView.layer.borderWidth = 2
                    imageView.image = image
                    imageView.layer.cornerRadius = 20
                    imageView.layer.masksToBounds = true
                    completion(view)
                }
            }
        }
    }
    
    // upload label......
    lazy var uploadLabelCount: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
}
