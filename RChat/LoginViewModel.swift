//
//  LoginViewModel.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class LoginViewModel {

    enum Mode {
        case login, signup
    }

    let mode : Mode

    init(mode: Mode){
        self.mode = mode
    }

    var username: String = ""
    var password: String = ""

    // FROM UI
    func attemptLogin(){
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password)
        isProcessingCallback?(true)
        SyncUser.logIn(with: usernameCredentials, server: RChatConstants.authServerEndpoint) { [weak self] (user, error) in
            DispatchQueue.main.sync {
                self?.isProcessingCallback?(false)
                if let user = user {
                    self?.setPermissions(user: user)
                    self?.authSuccessCallback?(user)
                    return
                } else if let error = error {
                    let description = error.localizedDescription
                    self?.authErrorCallback?(description)
                    return
                }
                let errorMessage = "No user was found!"
                self?.authErrorCallback?(errorMessage)
            }
        }
    }

    func attemptRegistration(){
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: true)
        isProcessingCallback?(true)
        SyncUser.logIn(with: usernameCredentials, server: RChatConstants.authServerEndpoint) { [weak self] (user, error) in
            guard let `self` = self else { return }
            DispatchQueue.main.sync {
                self.isProcessingCallback?(false)
                if let user = user {
                    self.setPermissions(user: user)
                    self.authSuccessCallback?(user)
                    return
                } else if let error = error {
                    let description = error.localizedDescription
                    self.authErrorCallback?(description)
                    return
                }
                let errorMessage = "No user was found!"
                self.authErrorCallback?(errorMessage)
            }
        }
    }

    // TO UI
    var isProcessingCallback: ((_ isProcessing: Bool) -> Void)? {
        didSet {
            isProcessingCallback?(false)
        }
    }
    var authSuccessCallback : ((_ user: SyncUser) -> Void)?
    var authErrorCallback: ((_ errorMessage: String) -> Void)?
    var modeCallback : ((_ mode: Mode) -> Void)? {
        didSet {
            modeCallback?(self.mode)
        }
    }

    private func setPermissions(user: SyncUser){
        // set permissions
        let managementRealm = try! user.managementRealm()
        try! managementRealm.write {
            let permissionChange = SyncPermissionChange(realmURL: RChatConstants.objectServerEndpoint.absoluteString,
                                                        // The remote Realm URL on which to apply the changes
                userID: "*", // The user ID for which these permission changes should be applied
                mayRead: true,         // Grant read access
                mayWrite: true,        // Grant write access
                mayManage: false)      // Grant management access
            managementRealm.add(permissionChange)
        }


        let newUser = User()
        newUser.userId = user.identity!
        newUser.username = self.username
        newUser.displayName = self.username

        let realm = RChatConstants.Realms.global
        try! realm.write {
            realm.add(newUser, update: true)
        }

        Conversation.generateDefaultConversation()
    }

}
