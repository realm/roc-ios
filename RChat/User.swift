//
//  User.swift
//  RChat
//
//  Created by Max Alexander on 2/1/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    dynamic var userId: String = ""
    dynamic var username: String = ""
    dynamic var displayName : String = ""
    dynamic var avatarImage: Data?

    var defaultingName: String {
        if !displayName.isEmpty {
            return displayName
        }
        return "@\(username)"
    }

    var defaultingAvatarImage: UIImage? {
        if avatarImage != nil {
            return UIImage(data: avatarImage!)
        }
        return UIImage(named: "profile_icon")! 
    }
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    override static func ignoredProperties() -> [String] {
        return ["defaultingName", "defaultingAvatarImage"]
    }
}

extension User {

    static func getMe() -> User! {
        let realm = RChatConstants.Realms.global
        return realm.object(ofType: User.self, forPrimaryKey: RChatConstants.myUserId)
    }

    static func searchForUsers(searchTerm: String) -> Results<User> {
        let realm = RChatConstants.Realms.global
        let predicate = NSPredicate(format: "(username contains[c] %@ OR displayName contains[c] %@) AND (userId != %@)", searchTerm, searchTerm, RChatConstants.myUserId)
        return realm.objects(User.self).filter(predicate)
    }
    
    func hasCustomAvatar() -> Bool {
        return avatarImage != nil
    }

    func avatarHash() -> String? {
        if avatarImage != nil {
            return String(describing: avatarImage?.hashValue)
        }
        return nil
    }

}
