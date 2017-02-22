//
//  ImageUploadService.swift
//  RChat
//
//  Created by Max Alexander on 2/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import AWSCore
import AWSS3

struct UploadImageError : Error {
    var friendlyErrorMessage: String = "Uh oh something went wrong when uploading."
}


class ImageUploadService {

    static let sharedInstance = ImageUploadService()

    let bucketName: String
    private let transferUtility : AWSS3TransferUtility


    private var uploadReference : [String: (completedBytes: Float, totalBytes: Float)] = [:]

    private init(){
        guard let path = Bundle.main.path(forResource: "thirdparty", ofType: "plist")  else {
            fatalError("This app needs a thirdparty.plist")
        }
        let dictionary = NSDictionary(contentsOfFile: path)!["S3"] as! [String: String]
        let cognitoApplicationId = dictionary["CognitoApplicationId"]!
        bucketName = dictionary["BucketName"]!

        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegionType.USEast1, identityPoolId: cognitoApplicationId)
        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration

        transferUtility = AWSS3TransferUtility.default()
    }


    private func updateProgress(key: String, completedBytes: Float, totalBytes: Float){
        let progress = completedBytes / totalBytes;
        if progress == 1 {
            uploadReference.removeValue(forKey: key)
        }
        uploadReference[key] = (completedBytes: completedBytes, totalBytes: totalBytes)
    }

    private func errorProgress(key: String? = nil){
        if let key = key {
            uploadReference.removeValue(forKey: key)
        }else {
            uploadReference.removeAll()
            //TO DO: reference a banner
        }
    }


    func uploadImage(image: UIImage, completionHandler: @escaping ((_ uploadedUrl: String?, _ error: Error?) -> Void)) {
        let data = UIImageJPEGRepresentation(image, 0.6)!

        let uuid = NSUUID().uuidString
        let fileExtension = "jpg"
        let contentType = "image/jpeg"
        let key = "uploads/\(uuid).\(fileExtension)"
        let fullUrl = "https://s3.amazonaws.com/\(bucketName)/\(key)"

        let expression = AWSS3TransferUtilityUploadExpression()

        expression.progressBlock =  { [unowned self] task, progress in
            let numerator = Float(progress.completedUnitCount)
            let denominator = Float(progress.totalUnitCount)
            if progress.isCancelled {
                self.errorProgress(key: key)
            }else {
                self.updateProgress(key: key, completedBytes: numerator, totalBytes: denominator)
            }
        }

        let transferCompletionHandler : AWSS3TransferUtilityUploadCompletionHandlerBlock = {  (task, error) -> Void in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(nil, error)
                    self.errorProgress(key: key)
                }
                else{
                    completionHandler(fullUrl, nil)
                    self.updateProgress(key: key, completedBytes: 1, totalBytes: 1)
                }
            }
        }

        let _ = transferUtility.uploadData(data, bucket: bucketName, key: key, contentType: contentType, expression: expression, completionHandler: transferCompletionHandler)
    }

}
