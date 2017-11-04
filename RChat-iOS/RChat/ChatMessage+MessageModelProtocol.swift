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
import RealmSwift
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
        //return user!.userId // <-- this is an unafe reference to the user object  DHMS
        var idString = ""
        DispatchQueue.main.sync { // yikes -- not what we want to do - but have to find a place to put the safe thread reference code in the code that uses this getter... :\
            idString =  self.user!.userId
        }
        return idString
    }

    var isIncoming : Bool {
        return user!.isSameObject(as: User.getMe())
    }

    // Realm will aggressively try to send it over, this is out of our control
    var status: MessageStatus {
        return .success
    }
    
}
