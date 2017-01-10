//
//  RChatDataSource.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import Chatto

class RChatDataSource : ChatDataSourceProtocol {

    var delegate: ChatDataSourceDelegateProtocol?
    var chatItems: [ChatItemProtocol] = []

    init(conversationId: String){

    }

    var hasMoreNext: Bool {
        return false
    }

    var hasMorePrevious: Bool {
        return false
    }

    func loadNext() {

    }

    func loadPrevious() {

    }

    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion: ((Bool)) -> Void) {
        completion(false)
    }

    func sendMessage(text: String){
        let chatMessage = ChatMessage()
        chatMessage.messageId = NSUUID().uuidString
        chatMessage.text = text
        chatMessage.userId = "mbalex99"
        chatItems.append(RChatTextMessageModel(messageModel: chatMessage))
        delegate?.chatDataSourceDidUpdate(self)
    }

}
