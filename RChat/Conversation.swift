//
//  Conversation.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import RealmSwift


class Conversation : Object {

    dynamic var conversationId : String = UUID().uuidString

    override static func primaryKey() -> String? {
        return "conversationId"
    }

}
