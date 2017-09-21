//
//  SettingsViewModel.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import RealmSwift

extension Data {
    func toImage() -> UIImage? {
        if let tmpImage = UIImage(data: self) {
            return tmpImage
        }
        return nil
    }
}

class SettingsViewModel {

    // FROM UI
    func profileRowDidTap(){
        presentProfileImageChangeAlert?()
    }
    func logoutRowDidTap(){
        presentLogoutAlert?()
    }
    func confirmLogoutDidTap(){
        SyncUser.current?.logOut()
        returnToWelcomeViewController?()
    }
    func saveRowDidTap(){
        let myUser = User.getMe()
        let realm = RChatConstants.Realms.global
        try! realm.write {
            myUser?.displayName = self.displayName ?? ""
            myUser?.sharePresence = self.sharePresence ?? false
            myUser?.shareLocation = self.shareLocation ?? false
            if self.avatarImage != nil {
                myUser?.avatarImage = UIImagePNGRepresentation(self.avatarImage!) as Data?
            } else {
                print("User avatar was nil.")
            }
        }
        showSaveSuccessBanner?()
    }

    func saveLocationEnableChoice() {
        let myUser = User.getMe()
        let realm = RChatConstants.Realms.global
        try! realm.write {
            myUser?.shareLocation = self.shareLocation ?? false
        }
        showSaveSuccessBanner?()
    }
    
    func savePresenceEnableChoice() {
        let myUser = User.getMe()
        let realm = RChatConstants.Realms.global
        try! realm.write {
            myUser?.sharePresence = self.sharePresence ?? false
        }
        showSaveSuccessBanner?()
    }
    

    // TO UI
    var presentProfileImageChangeAlert: ((Void) -> ())?
    var presentLogoutAlert: ((Void) -> ())?
    var returnToWelcomeViewController: ((Void) -> ())?
    var showSaveSuccessBanner: ((Void) -> ())?

    var username: String?
    var displayName: String?
    var shareLocation: Bool?
    var sharePresence: Bool?
    var avatarImage: UIImage?
    
    
    init(){
        username = User.getMe().username
        displayName =  User.getMe().displayName
        shareLocation = User.getMe().shareLocation
        sharePresence = User.getMe().sharePresence
        avatarImage = User.getMe().avatarImage?.toImage() ?? genericUserImage()
    }
    
    func genericUserImage() -> UIImage {
        return UIImage(named:"camera-50")!
    }

}
