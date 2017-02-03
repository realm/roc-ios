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
        let myUser = User.getMe()
        let realm = RChatConstants.Realms.global
        try! realm.write {
            myUser?.displayName = self.displayName ?? ""
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

    init(){
        username = User.getMe().username
        displayName =  User.getMe().displayName
    }

}
