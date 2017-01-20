//
//  WelcomeViewModel.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class WelcomeViewModel {

    // FROM UI
    func loginDidTap(){
        goToLogin?()
    }

    func registerDidTap(){
        goToSignup?()
    }

    // TO UI
    var isAlreadyLoggedIn : ((_ isLoggedIn: Bool) -> Void)? {
        didSet {
            isAlreadyLoggedIn?(RChatConstants.isLoggedIn)
        }
    }

    var goToLogin : (() -> Void)?
    var goToSignup : (() -> Void)?

}
