//
//  SettingsViewModel.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import RealmSwift

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
        let depictedAvatarIsPlaceholder = String(describing:avatarImage?.hashValue) == String(describing: UIImage(named: "profile_icon")?.hashValue)
        let myUser = User.getMe()
        let realm = RChatConstants.Realms.global
        try! realm.write {
            myUser?.displayName = self.displayName ?? ""

            // Need to check 2 things before we possibly write avatar data to the Realm:
            //    1) That there's no custom avatar currently, and that the avatar we're showing isn't the placeholder image
            //     - no use in saving that! 
            // And,
            //    2) That if they DO have a custom avatar that the user has, in fact, changed the image.
            //    We check that by comparing the hashes of the stored image and the one currently on display; only
            //    update for a different image here.'
            if User.getMe().hasCustomAvatar() == false && depictedAvatarIsPlaceholder == false ||
                User.getMe().hasCustomAvatar() == true && User.getMe().avatarHash() != String(describing:avatarImage?.hashValue)  {
             myUser?.avatarImage = UIImagePNGRepresentation(avatarImage!) as Data?
            }
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
    var avatarImage: UIImage?
    var hasCutomAvatar = false
    init(){
        username = User.getMe().username
        displayName =  User.getMe().displayName
        avatarImage = User.getMe().defaultingAvatarImage
    }

}
