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

    func searchForUsers(searchTerm: String) -> Results<User> {
        let realm = RChatConstants.Realms.globalUsers
        let predicate = NSPredicate(format: "username LIKE[c] %@", searchTerm)
        return realm.objects(User.self).filter(predicate)
    }

}
