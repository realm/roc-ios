//
//  Message.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import RealmSwift
import Chatto
import ChattoAdditions

class ChatMessage : Object {

    dynamic var messageId: String = UUID().uuidString
    dynamic var userId:  String = ""
    dynamic var conversationId: String = UUID().uuidString
    dynamic var mimeType: String = MimeType.textPlain.rawValue
    /// represents the simple text representation of the message
    dynamic var text: String = ""
    /// possible storage of JSON information. Represented as a JSON
    dynamic var extraInfo: NSData?
    dynamic var timestamp: Date = Date()
    let conversations = LinkingObjects(fromType: Conversation.self, property: "chatMessages")

    override static func primaryKey() -> String? {
        return "messageId"
    }
}


extension ChatMessage {

    static func sendTextChatMessage(conversation: Conversation, text: String){
        let chatMessage = ChatMessage()
        chatMessage.userId = RChatConstants.myUserId
        chatMessage.conversationId = conversation.conversationId
        chatMessage.text = text
        let realm = RChatConstants.Realms.global
        try! realm.write {
            conversation.chatMessages.append(chatMessage)
        }
    }

}
