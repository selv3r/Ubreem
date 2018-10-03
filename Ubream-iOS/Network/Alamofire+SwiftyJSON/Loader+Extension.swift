//
//  Loader+Extension.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 5/14/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit
import NVActivityIndicatorView

extension Loader {
    
    //Download Video or PDF, Audio..................................
    func downloadData(with url: String, completion: @escaping (_ fileData: Data?, _ downloaded: Double?) -> ()) {
        
        let dest = Alamofire.DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        
        Alamofire.download(URLs.imageUrl + url, to: dest)
            .downloadProgress(queue: .main) { (progress) in
//                print(progress.fractionCompleted)
                print((progress.completedUnitCount / 1024) / 1024) // MB Downloaded
                let downMB = (progress.fractionCompleted)
                completion(nil, downMB)
        }
            .response { (response) in
                if let url = response.destinationURL {
                    let data = try? Data(contentsOf: url)
                    //                let path = response.destinationURL?.absoluteURL
                    DispatchQueue.main.async {
                        completion(data, nil)
                    }
                }
        }
    }
    
    func uploadData(image: UIImage?, video: Data?, pdfFile: Data?, audio: Data?, url: String, api_token: String, fileName: String? = "video.mp4", ext: String = "mp4", completion: @escaping responseUpload) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(uploadLabelCount)
        uploadLabelCount.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        uploadLabelCount.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 80).isActive = true
        Alamofire.upload(multipartFormData: { (form) in
            
            if let image = image, let  data = UIImageJPEGRepresentation(image, 0.5)
            {
                form.append(data, withName: "file", fileName: "image.jpg", mimeType: "image/jpg")
            }
            if let video = video
            {
                form.append(video, withName: "file", fileName: "\(fileName ?? "video.mp4")", mimeType: "video/\(ext)")
            }
            if let audio = audio
            {
                form.append(audio, withName: "file", fileName: "recording.m4a", mimeType: "audio/m4a")
            }
            if let pdfFile = pdfFile
            {
                form.append(pdfFile, withName: "file", fileName: "file.pdf", mimeType: "application/pdf")
            }
            form.append(api_token.data(using: .utf8)!, withName: "api_token")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress: Progress) in
                    let uploadedMB = progress.fractionCompleted * 100
                    self.uploadLabelCount.text = String(format: "%0.1f Uploaded", uploadedMB)
                    print("=============\(uploadedMB)******")
                    completion(nil, nil, uploadedMB)
                })
                upload.validate(statusCode: 200...422)
                upload.responseJSON { response in
                    switch response.result {
                    case .failure( let error):
                        UIApplication.topViewController()?.StopLoading()
                        self.uploadLabelCount.removeFromSuperview()
                        print(error.localizedDescription)
                        completion(error.localizedDescription, nil, nil)
                    case .success(let value):
                        self.uploadLabelCount.removeFromSuperview()
                        self.parseResponse(json: JSON(value), completion: { (error, json) in
                            completion(error, json, nil)
                        })
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                UIApplication.topViewController()?.StopLoading()
                completion(error.localizedDescription, nil, nil)
                // end
            }
        }
    }
    
    
    
    func uploadVerifyLetterData(image: UIImage?, pdfFile: Data?, url: String, api_token: String, completion: @escaping responseUpload) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(uploadLabelCount)
        
        uploadLabelCount.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        uploadLabelCount.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 80).isActive = true
        
        Alamofire.upload(multipartFormData: { (form) in
            
            if let image = image, let  data = UIImageJPEGRepresentation(image, 0.5)
            {
                form.append(data, withName: "verify_latter", fileName: "image.jpg", mimeType: "image/jpg")
            }
            if let pdfFile = pdfFile
            {
                form.append(pdfFile, withName: "verify_latter", fileName: "file.pdf", mimeType: "application/pdf")
            }
            form.append(api_token.data(using: .utf8)!, withName: "api_token")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress: Progress) in
                    let uploadedMB = progress.fractionCompleted * 100
                    self.uploadLabelCount.text = String(format: "%0.1f Uploaded", uploadedMB)
                    print("=============\(uploadedMB)******")
                    completion(nil, nil, uploadedMB)
                })
                upload.validate(statusCode: 200...422)
                upload.responseJSON { response in
                    switch response.result {
                    case .failure( let error):
                        UIApplication.topViewController()?.StopLoading()
                        self.uploadLabelCount.removeFromSuperview()
                        print(error.localizedDescription)
                        completion(error.localizedDescription, nil, nil)
                    case .success(let value):
                        self.uploadLabelCount.removeFromSuperview()
                        self.parseResponse(json: JSON(value), completion: { (error, json) in
                            completion(error, json, nil)
                        })
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                UIApplication.topViewController()?.StopLoading()
                completion(error.localizedDescription, nil, nil)
            }
        }
    }
    

    //JSON Parsing
    func parseResponse(json: JSON, completion: @escaping response ) {
        if let error = json["error"].string, error == "Unauthenticated." {
            //Room.deleteDatabase()
            //User.deleteAllUsers(managedContext: CoreDataStack.shared.mainContext)
            helper.goToStoryboard(with: "Authentication")
            return
        }
        if let array = json["errors"].array {
            if let firstError = array.first!["message"].string {
                completion(firstError, nil)
                return
            }
        }
        completion(nil, json)
    }
}
