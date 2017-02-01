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
    dynamic var displayName : String = ""

    override static func primaryKey() -> String? {
        return "conversationId"
    }

}

extension Conversation {

    static func createConversation(userIds: [String]){

    }

}

class ConversationPointer : Object {
    dynamic var id : String = ""

}
