//
//  Conversation.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import RealmSwift

class Conversation : Object {

    dynamic var conversationId: String = RChatConstants.genericConversationId
    dynamic var displayName: String = ""
    dynamic var unreadCount: Int = 0
    let users = List<User>()
    let chatMessages = List<ChatMessage>()

    // This should show some sort of name even if the display name is empty
    var defaultingName: String {
        if !displayName.isEmptyOrWhitespace {
            return displayName
        }
        return users
            .filter({ $0.userId != RChatConstants.myUserId })
            .map({ $0.defaultingName }).joined(separator: ",")
    }

    override static func primaryKey() -> String? {
        return "conversationId"
    }

    override static func ignoredProperties() -> [String] {
        return ["defaultingName"]
    }

}

extension Conversation {

    static func searchForConversations(searchTerm: String) -> Results<Conversation> {
        let realm = RChatConstants.Realms.global
        
        let predicate = NSPredicate(format: "displayName contains[c] %@", searchTerm)
        return realm.objects(Conversation.self).filter(predicate)

    }

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
        let realm = RChatConstants.Realms.global
        
        let createConversation = { () -> Conversation in
            let conversation = realm.create(Conversation.self, value: [
                "conversationId": RChatConstants.genericConversationId,
                "displayName": "Welcome to RChat"
                ], update: true)
            conversation.users.append(User.getMe())
            
            return conversation
        }
        
        // Just call block, already in transaction
        if realm.isInWriteTransaction {
            return createConversation()
        }
        
        realm.beginWrite()
        let conversation = createConversation()
        try! realm.commitWrite()
        
        return conversation
    }

    static func observeConversationBy(conversationId: String, callback: @escaping ((Conversation?) -> Void)) -> NotificationToken {
        let realm = RChatConstants.Realms.global
        let results = realm.objects(Conversation.self).filter("conversationId = %@", conversationId)
        return results.observe({ (_) in
            let conversation = results.first
            callback(conversation)
        })
    }

}

