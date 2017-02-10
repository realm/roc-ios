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
    
    var permissionToken: NotificationToken?
    var permissionChange: SyncPermissionChange?
    
    deinit {
        if let permissionToken = self.permissionToken {
            permissionToken.stop()
        }
    }

    // FROM UI
    func attemptLogin(){
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password)
        isProcessingCallback?(true)
        SyncUser.logIn(with: usernameCredentials, server: RChatConstants.authServerEndpoint) { [weak self] (user, error) in
            guard let `self` = self else { return }
            DispatchQueue.main.sync {
                self.isProcessingCallback?(false)
                if let user = user {
                    self.setup(user: user)
                    
                    // Should only be called by an admin user
                    //self.updateGlobalRealmPermission(user: user)
                    
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

    func attemptRegistration(){
        let usernameCredentials = SyncCredentials.usernamePassword(username: username, password: password, register: true)
        isProcessingCallback?(true)
        SyncUser.logIn(with: usernameCredentials, server: RChatConstants.authServerEndpoint) { [weak self] (user, error) in
            guard let `self` = self else { return }
            DispatchQueue.main.sync {
                self.isProcessingCallback?(false)
                if let user = user {
                    self.setup(user: user)
                    
                    // Should only be called by an admin user
                    //self.updateGlobalRealmPermission(user: user)
                    
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
    
    // THIS SHOULD ONLY BE CALLED WITH AN ADMIN USER!
    private func updateGlobalRealmPermission(user: SyncUser) {
        // set permissions
        let managementRealm = try! user.managementRealm()
        
        self.permissionChange = SyncPermissionChange(realmURL: RChatConstants.globalRealmURL.absoluteString,
                                                    // The remote Realm URL on which to apply the changes
            userID: "*", // The user ID for which these permission changes should be applied
            mayRead: true,         // Grant read access
            mayWrite: true,        // Grant write access
            mayManage: false)      // Grant management access
        
        try! managementRealm.write {
            managementRealm.add(self.permissionChange!)
        }
        
        // Listen for update to permission change
        self.permissionToken = self.permissionChange!.addNotificationBlock({ [weak self] (objectChange) in
            switch objectChange {
            case .change(let properties):
                if let statusChange = properties.first(where: { $0.name == "status" }) {
                    let status = statusChange.newValue as! SyncManagementObjectStatus
                    switch status {
                    case .success:
                        print("Successfully set global Realm permission")
                        self?.permissionToken?.stop()
                    case .notProcessed:
                        print("Did not process global Realm permission")
                        self?.permissionToken?.stop()
                    case .error:
                        print("Error in setting global Realm permission")
                        self?.permissionToken?.stop()
                    }
                }
            case .deleted:
                break
            case .error(let error):
                print(error)
            }
        })
    }

    private func setup(user: SyncUser){
        let realm = RChatConstants.Realms.global

        try! realm.write {
            let defaultValues = ["userId": user.identity!,
                                 "username": self.username,
                                 "displayName" : self.username]
            let newUser = realm.create(User.self, value: defaultValues, update: true)
            
            let defaultConversation  = Conversation.generateDefaultConversation()
            defaultConversation.users.append(newUser)
        }
    }

}
