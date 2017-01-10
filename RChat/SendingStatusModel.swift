//
//  SendingStatusModel.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

// This is a dirty implementation that shows what's needed to add a new type of element
// @see ChatItemsDemoDecorator

class SendingStatusModel: ChatItemProtocol {
    let uid: String
    static var chatItemType: ChatItemType {
        return "decoration-status"
    }

    var type: String { return SendingStatusModel.chatItemType }
    let status: MessageStatus

    init (uid: String, status: MessageStatus) {
        self.uid = uid
        self.status = status
    }
}
