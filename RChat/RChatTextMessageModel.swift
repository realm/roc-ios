//
//  RChatTextMessageModel.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions


class RChatTextMessageModel: TextMessageModel<ChatMessage>, RChatMessageModelProtocol {
    init(messageModel: ChatMessage){
        super.init(messageModel: messageModel, text: messageModel.text)
    }

    var status: MessageStatus {
        get {
            return self._messageModel.status
        }
        set {
            self._messageModel.status = newValue
        }
    }
}
