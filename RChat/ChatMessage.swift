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
    dynamic var user:  User?
    
    // Payload: text or image depending on mimetype
    dynamic var mimeType: String = MimeType.textPlain.rawValue
    dynamic var text: String = ""
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
        chatMessage.user = User.getMe()
        chatMessage.text = text
        let realm = conversation.realm!
        try! realm.write {
            conversation.chatMessages.append(chatMessage)
        }
    }

    
    // MARK:  Insert image
    static func sendImageChatMessage(conversation: Conversation, image: UIImage?){
        guard image != nil else {
            return
        }
        let chatMessage = ChatMessage()
        chatMessage.user = User.getMe()
        chatMessage.mimeType = MimeType.imagePNG.rawValue
        
        // @FIXME: this is a placeholder to deal with an image size support issue
        let resizedImage = image?.resizeImage(targetSize: CGSize(width:image!.size.width / 2, height: image!.size.height / 2))
        
        chatMessage.extraInfo = (UIImagePNGRepresentation(resizedImage!)! as NSData)
        let realm = conversation.realm!
        try! realm.write {
            conversation.chatMessages.append(chatMessage)
        }
    }
    

    static func searchInChats(searchTerm: String) -> Results<ChatMessage> {
        let realm = RChatConstants.Realms.global        
        let predicate = NSPredicate(format: "text contains[c] %@", searchTerm)
        return realm.objects(ChatMessage.self).filter(predicate)
    }
}
