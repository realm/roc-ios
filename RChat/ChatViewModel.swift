//
//  ChatViewModel.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import RealmSwift
import Chatto

class ChatViewModel : ChatDataSourceProtocol {

    var delegate: ChatDataSourceDelegateProtocol?
    var chatItems: [ChatItemProtocol] = []
    var notificationToken : NotificationToken?
    var observeConversationToken : NotificationToken?

    private var isFirst: Bool = true

    var defaultingNameCallback : ((String) -> Void)? {
        didSet {
            self.defaultingNameCallback?(conversation?.defaultingName ?? "")
        }
    }

    var conversation : Conversation? {
        didSet {
            observeConversationToken?.stop()
            notificationToken?.stop()
            isFirst = true
            guard let c = conversation else { return }
            let chatMessages = RChatConstants.Realms.global.objects(ChatMessage.self)
                .filter("conversationId = %@", c.conversationId)
                .sorted(byKeyPath: "timestamp", ascending: true)

            notificationToken = chatMessages
                .addNotificationBlock({ [weak self] (changes) in
                    guard let `self` = self else { return }
                    self.isFirst = false
                    var items = [ChatItemProtocol]()
                    for m in Array(chatMessages).map({ ChatMessage(value: $0) }) {
                        if m.mimeType == MimeType.textPlain.rawValue {
                            items.append(RChatTextMessageModel(messageModel: m))
                        }
                        if m.mimeType == MimeType.imagePNG.rawValue {
                            items.append(RChatImageMessageModel(messageModel: m, imageSize: CGSize(width:256, height:256), image: UIImage(data:m.extraInfo! as Data)!))
                        }
                    }
                    self.chatItems = items
                    self.delegate?.chatDataSourceDidUpdate(self, updateType: self.isFirst ? .reload : .normal)
                })

            observeConversationToken = Conversation.observeConversationBy(conversationId: c.conversationId) { [weak self] conversation in
                guard let `self` = self else { return }
                self.defaultingNameCallback?(conversation?.defaultingName ?? "")
            }
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
        guard let conversation = self.conversation else { fatalError("We are not attached to a conversation. It is nil") }
        ChatMessage.sendTextChatMessage(conversation: conversation, text: text)
    }

    deinit {
        notificationToken?.stop()
        observeConversationToken?.stop()

    }

}
