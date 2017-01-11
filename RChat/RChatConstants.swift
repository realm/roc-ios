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
            return "mbalex99"
            //return UserDefaults.standard.string(forKey: "_myUserId")
        }set (value){
            UserDefaults.standard.set(value, forKey: "_myUserId")
        }
    }

    /// Referencing Flat Colors from here : https://flatuicolors.com/
    struct Colors {
        //APP
        static var primaryColor = UIColor(hexString: "#487CFF")

        //WHITES AND GRAY
        static var clouds = UIColor(hexString: "#ecf0f1")
        static var concrete = UIColor(hexString: "#95a5a6")
        static var silver = UIColor(hexString: "#bdc3c7")
        static var asbestos = UIColor(hexString: "#7f8c8d")
        //BLUES
        static var peterRiver = UIColor(hexString: "#3498db")
        static var belizeHole = UIColor(hexString: "#2980b9")
        static var wetAsphalt = UIColor(hexString: "#34495e")
        static var midnightBlue = UIColor(hexString: "#2c3e50")
    }

    struct Fonts {
        static var regularFont = UIFont.systemFont(ofSize: 16)
        static var boldFont = UIFont.boldSystemFont(ofSize: 16)
        static var dateFont = UIFont.systemFont(ofSize: 14)
    }

    struct Images {
        static var attachIcon = UIImage(named: "attach_icon")?.withRenderingMode(.alwaysTemplate)
        static var sendIcon = UIImage(named: "send_icon")?.withRenderingMode(.alwaysTemplate)
        static var menuIcon = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate)
    }

}
