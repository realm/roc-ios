////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////
//
//  RLMLoginViewController.swift
//  RChat
//
//  Created by David Spector on 6/1/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit
import RealmSwift
import RealmLoginKit

class RLMLoginViewController: UIViewController {
    var loginViewController: LoginViewController!
    var token: NotificationToken!
    var myIdentity = SyncUser.current?.identity!
    
    let useAsyncOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loginViewController = LoginViewController(style: .lightOpaque)
        loginViewController.isServerURLFieldHidden = false
        loginViewController.isRegistering = true
        
        if (SyncUser.current != nil) {
            // yup - we've got a stored session, so just go right to the UITabView
            self.navigationController?.setViewControllers([ChatViewController()], animated: true)
        } else {
            // show the RealmLoginKit controller
            if loginViewController!.serverURL == nil {
                loginViewController!.serverURL = RChatConstants.authServerEndpoint.absoluteString //Constants.syncAuthURL.absoluteString
            }
            
            // Set a closure that will be called on successful login
            loginViewController.loginSuccessfulHandler = { user in
                DispatchQueue.main.async {
                    self.setup(user: user)
                    self.loginViewController!.dismiss(animated: true, completion: nil)
                    self.navigationController?.setViewControllers([ChatViewController()], animated: true)
                    
                    // Realm.asyncOpen(configuration: commonRealmConfig(user:SyncUser.current!)) { realm, error in
                    //     if let realm = realm {
                    //     } else if let error = error {
                    //         print("Error on return from AsyncOpen(): \(error)")
                    //     }
                    // } // of asyncOpen()
                    
                } // of main queue dispatch
            }// of login controller
            
            present(loginViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setPermissionForRealm(_ realm: Realm?, accessLevel: SyncAccessLevel, personID: String) {
        if let realm = realm {
            let permission = SyncPermission(realmPath: realm.configuration.syncConfiguration!.realmURL.path,
                identity: personID,
                accessLevel: accessLevel)
            SyncUser.current?.apply(permission) { error in
                if let error = error {
                    print("Error when attempting to set permissions: \(error.localizedDescription)")
                    return
                } else {
                    print("Permissions successfully set")
                }
            }
        }
    }
    
    
    private func setup(user: SyncUser){
        let realm = RChatConstants.Realms.global
        
        try! realm.write {
            let defaultValues = ["userId": user.identity!,
                                 "username": loginViewController.username,
                                 "displayName" : loginViewController.username]
            let newUser = realm.create(User.self, value: defaultValues, update: true)
            
            let defaultConversation  = Conversation.generateDefaultConversation()
            defaultConversation.users.append(newUser)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
