//
//  RChatDataSource.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import Chatto
import RealmSwift

class RChatDataSource : ChatDataSourceProtocol {

    var delegate: ChatDataSourceDelegateProtocol?
    var chatItems: [ChatItemProtocol] = []
    var notificationToken : NotificationToken?

    var conversation : Conversation? {
        didSet {
            notificationToken?.stop()
            guard let c = conversation else { return }
            notificationToken = c.chatMessages.sorted(byProperty: "timestamp", ascending: false)
                .addNotificationBlock({ [weak self] (changes) in
                    guard let `self` = self else { return }

                })
        }
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
