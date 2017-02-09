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

class ImageUploadService {

    static let sharedInstance = ImageUploadService()

    let bucketName: String
    private let transferUtility : AWSS3TransferUtility

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


    func uploadImage(image: UIImage, completionHandler: @escaping ((_ uploadedUrl: String) -> Void)) {
        let data = UIImageJPEGRepresentation(image, 0.6)!

        let uuid = NSUUID().uuidString
        let fileExtension = "jpg"
        let contentType = "image/jpeg"
        let key = "uploads/\(uuid).\(fileExtension)"
        let fullUrl = "https://s3.amazonaws.com/edenmessenger/\(key)"
    }

}
