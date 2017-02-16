//
//  SettingsViewController+ImagePicking.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

extension SettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentCamera(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }

    func presentPhotoLibrary(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.view.backgroundColor = .white
        imagePickerController.topViewController?.view.backgroundColor = .white
        self.present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let resizedImage = image.resizeImage(targetSize: CGSize(width: 100, height: 100))
        // Note that since we allow the user to abandon changes we are *not* setting the actual user record here
        // only this view's dipslay elements, in the case the image in the row, and the SettingViewController's
        // avatarImage property
        self.profileRow.value = resizedImage
        picker.dismiss(animated: true, completion: nil)
    }

}
