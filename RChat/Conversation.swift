//
//  Conversation.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import RealmSwift

class Conversation : Object {

    dynamic var conversationId: String = UUID().uuidString
    dynamic var displayName: String = ""
    let users = List<User>()
    let chatMessages = List<ChatMessage>()

    // This should show some sort of name even if the display name is empty
    var defaultingName: String {
        if !displayName.isEmptyOrWhitespace {
            return displayName
        }
        return users.map({ $0.defaultingName }).joined(separator: ",")
    }

    override static func primaryKey() -> String? {
        return "conversationId"
    }

    override static func ignoredProperties() -> [String] {
        return ["defaultingName"]
    }

}

extension Conversation {

    static func generateDirectMessage(userId1: String, userId2: String) -> String {
        let parts = [userId1, userId2].sorted(by: { $0 < $1 })
        return "dm|\(parts[0])|\(parts[1])"
    }

    static func putConversation(users: [User]) -> Conversation {
        if users.count < 2 {
            fatalError("Cannot create a conversation with less than 2 users")
        }
        var conversationId : String = UUID().uuidString
        if users.count == 2 {
            conversationId = generateDirectMessage(userId1: users[0].userId, userId2: users[1].userId)
        }
        let realm = RChatConstants.Realms.global
        let conversation = Conversation()
        conversation.conversationId = conversationId
        conversation.users.append(objectsIn: users)
        try! realm.write {
            realm.add(conversation, update: true)
        }
        return conversation
    }

    @discardableResult
    static func generateDefaultConversation() -> Conversation {
        let conversation = Conversation()
        conversation.conversationId = RChatConstants.genericConversationId
        conversation.displayName = "Welcome to RChat"
        let realm = RChatConstants.Realms.global
        try! realm.write {
            realm.add(conversation, update: true)
        }
        return conversation
    }


}

class ConversationPointer : Object {
    dynamic var id : String = ""

}
