//
//  RChatConstants.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Foundation

struct RChatConstants {

    static var myUserId : String! {
        get {
            return UserDefaults.standard.string(forKey: "_myUserId")
        }set (value){
            UserDefaults.standard.set(value, forKey: "_myUserId")
        }
    }

    /// Referencing Flat Colors from here : https://flatuicolors.com/
    struct Colors {
        //WHITES AND GRAY
        static var clouds = UIColor(hexaString: "#ecf0f1")
        static var concrete = UIColor(hexaString: "#95a5a6")
        static var silver = UIColor(hexaString: "#bdc3c7")
        static var asbestos = UIColor(hexaString: "#7f8c8d")
        //BLUES
        static var peterRiver = UIColor(hexaString: "#3498db")
        static var belizeHole = UIColor(hexaString: "#2980b9")
    }

    struct Fonts {
        static var regularFont = UIFont.systemFont(ofSize: 16)
        static var boldFont = UIFont.boldSystemFont(ofSize: 16)
    }

    struct Images {
        static var attachIcon = UIImage(named: "attach_icon")?.withRenderingMode(.alwaysTemplate)
        static var sendIcon = UIImage(named: "send_icon")?.withRenderingMode(.alwaysTemplate)
        static var menuIcon = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate)
    }

}
