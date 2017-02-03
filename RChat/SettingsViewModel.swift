//
//  SettingsViewModel.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation

class SettingsViewModel {

    // FROM UI
    func profileRowDidTap(){
        presentProfileImageChangeAlert?()
    }
    func confirmLogoutDidTap(){

    }

    // TO UI
    var presentProfileImageChangeAlert: ((Void) -> ())?
    var presentLogoutAlert: ((Void) -> ())?

    var username: String?
    var displayName: String?

    init(){
        username = User.getMe().username
        displayName =  User.getMe().displayName
    }

}
