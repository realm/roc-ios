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

    override static func primaryKey() -> String? {
        return "userId"
    }
}

extension User {

    static func getMe() -> User! {
        let realm = RChatConstants.Realms.globalUsers
        return realm.object(ofType: User.self, forPrimaryKey: RChatConstants.myUserId)
    }

    static func searchForUsers(searchTerm: String) -> Results<User> {
        let realm = RChatConstants.Realms.globalUsers
        let predicate = NSPredicate(format: "(username contains[c] %@ OR displayName contains[c] %@) AND (userId != %@)", searchTerm, searchTerm, RChatConstants.myUserId)
        return realm.objects(User.self).filter(predicate)
    }

}
