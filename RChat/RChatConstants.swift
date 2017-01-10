//
//  RChatConstants.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation

struct RChatConstants {

    static var myUserId : String! {
        get {
            return UserDefaults.standard.string(forKey: "_myUserId")
        }set (value){
            UserDefaults.standard.set(value, forKey: "_myUserId")
        }
    }

}
