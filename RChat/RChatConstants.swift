//
//  RChatConstants.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

struct RChatConstants {

    static var myUserId : String! {
        get {
            return SyncUser.current?.identity
        }
    }

    static var isLoggedIn : Bool {
        return SyncUser.current != nil
    }

    static var objectServerEndpoint : URL {
        return URL(string: "realm://138.197.85.79:9080" )!
    }


    static var authServerEndpoint : URL {
        return URL(string: "http://138.197.85.79:9080" )!
    }
    
    static var globalRealmURL : URL {
        return URL(string: "\(RChatConstants.objectServerEndpoint.absoluteString)/global")!
    }
    
    static var myRealmURL : URL {
        return URL(string: "\(RChatConstants.objectServerEndpoint.absoluteString)/~/userRealm")!
    }

    static var genericConversationId : String = "pub|generic"

    /// Referencing Flat Colors from here : https://flatuicolors.com/
    struct Colors {
        //APP
        static var primaryColor = UIColor(hexString: "#38457c")
        static var primaryColorDark = UIColor(hexString: "#1C233F")

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
        //GREENS
        static var nephritis = UIColor(hexString: "#27ae60")
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
        static var profileIcon = UIImage(named: "profile_icon")?.withRenderingMode(.alwaysTemplate)
        static var penIcon = UIImage(named: "pen_icon")?.withRenderingMode(.alwaysTemplate)
        static var launchLogo = UIImage(named: "launch_logo")?.withRenderingMode(.alwaysTemplate)
        static var verticalMoreIcon = UIImage(named: "more_verticle_icon")?.withRenderingMode(.alwaysTemplate)
    }

    struct Numbers {
        static var horizontalSpacing : CGFloat = 16
        static var minorHorizontalSpacing : CGFloat = 8
        static var verticalSpacing : CGFloat = 8
        static var majorVerticalSpacing : CGFloat = 16
        static var cornerRadius : CGFloat = 4
    }

    struct Realms {
        static var global : Realm {
            let syncServerURL = RChatConstants.globalRealmURL
            let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: SyncUser.current!, realmURL: syncServerURL))
            return try! Realm(configuration: config)
        }
        static var myRealm : Realm {
            let syncServerURL = RChatConstants.myRealmURL
            let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: SyncUser.current!, realmURL: syncServerURL))
            return try! Realm(configuration: config)
        }
    }

}
