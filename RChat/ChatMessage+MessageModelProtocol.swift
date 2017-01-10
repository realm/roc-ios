//
//  ChatMessage+MessageModelProtocol.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions
import Chatto

/// This gives ChatMessage abilities to be consumed by Chatto's framework. They are just accessors.
extension ChatMessage : MessageModelProtocol {

    var uid: String {
        return messageId
    }

    var type: ChatItemType {
        return mimeType
    }

    var date: Date {
        return timestamp
    }

    var senderId: String {
        return userId
    }

    var isIncoming : Bool {
        return userId != RChatConstants.myUserId
    }

    // Realm will aggressively try to send it over, this is out of our control
    var status: MessageStatus {
        return .success
    }
    
}
