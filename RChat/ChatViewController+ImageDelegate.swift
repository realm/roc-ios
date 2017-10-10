//
//  ChatViewController+ImageDelegate.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

extension ChatViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func presentCamera(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }

    func presentPhotoLibrary(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        print("you've selected an image. \(image)")
        
        // this really doesn't need the level of infirection that the text messages uses ... as long as we have the required data
        // this should just make a new message and get it into the message stream. 
        ChatMessage.sendImageChatMessage(conversation: conversation, image: image)
    }

}
