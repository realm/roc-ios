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

    override static func primaryKey() -> String? {
        return "messageId"
    }
}


extension ChatMessage {

    func sendChatMessage(chatMessage: ChatMessage){

    }

}
