//
//  SearchResultTableViewCell.swift
//  RChat
//
//  Created by Max Alexander on 2/8/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class SearchResultTableViewCell: UITableViewCell {

    static let REUSE_ID = "SearchResultTableViewCell"
    static let HEIGHT: CGFloat = 44

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(label)
        constrain(label) { (label) in
            label.left == label.superview!.left + RChatConstants.Numbers.horizontalSpacing
            label.right == label.superview!.right - RChatConstants.Numbers.horizontalSpacing
            label.top == label.superview!.top
            label.bottom == label.superview!.bottom
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupWithUser(user: User){
        label.text = user.defaultingName
    }

    func setupWithConversation(conversation: Conversation){
        label.text = conversation.defaultingName
    }
    
    // Added support for searching inside chats
    func setupWithChat(chat: ChatMessage){
        let realm = RChatConstants.Realms.global
        let conversation = realm.objects(Conversation.self).filter("conversationId = %@", chat.conversationId).first
        label.text = conversation!.defaultingName
    }
    

}
