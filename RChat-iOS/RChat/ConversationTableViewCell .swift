//
//  ConversationTableViewCell .swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class ConversationTableViewCell : UITableViewCell {

    lazy var unreadIndicatorLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.cornerRadius = RChatConstants.Numbers.cornerRadius
        label.layer.masksToBounds = true
        label.textColor = .white
        label.font = RChatConstants.Fonts.boldFont
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()

    static let REUSE_ID = "ConversationTableViewCell"
    static let HEIGHT : CGFloat = 45

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        textLabel?.textColor = UIColor.white
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .left
        textLabel?.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(unreadIndicatorLabel)

        constrain(textLabel!, unreadIndicatorLabel) { (textLabel, unreadIndicatorLabel) in
            unreadIndicatorLabel.left == unreadIndicatorLabel.superview!.left + RChatConstants.Numbers.horizontalSpacing
            unreadIndicatorLabel.height == 28
            unreadIndicatorLabel.width == 28
            unreadIndicatorLabel.centerY == unreadIndicatorLabel.superview!.centerY
            
            textLabel.left == unreadIndicatorLabel.right + RChatConstants.Numbers.horizontalSpacing
            textLabel.top == textLabel.superview!.top
            textLabel.bottom == textLabel.superview!.bottom
            textLabel.right == unreadIndicatorLabel.superview!.right - RChatConstants.Numbers.minorHorizontalSpacing
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithConversation(conversation: Conversation){
        textLabel?.text = conversation.defaultingName
        textLabel?.font = conversation.unreadCount > 0 ? RChatConstants.Fonts.boldFont : RChatConstants.Fonts.regularFont
        unreadIndicatorLabel.text = conversation.unreadCount == 0 ? "0" : "\(conversation.unreadCount)"
        unreadIndicatorLabel.layer.borderWidth = conversation.unreadCount == 0 ? 2.0 : 0

        // let's colorize the unread count depending on how far behind the user is on a conversation...
        switch conversation.unreadCount {
        case 0:
            unreadIndicatorLabel.layer.borderColor = UIColor.lightGray.cgColor
            unreadIndicatorLabel.backgroundColor = UIColor.clear
            break
        case 1...25:
            unreadIndicatorLabel.layer.borderColor = UIColor.green.cgColor
            unreadIndicatorLabel.backgroundColor = UIColor.clear
            break
        case 26...50:
            unreadIndicatorLabel.layer.borderColor = UIColor.yellow.cgColor
            unreadIndicatorLabel.backgroundColor = UIColor.darkGray
            break
        default:
            unreadIndicatorLabel.layer.borderColor = UIColor.black.cgColor
            unreadIndicatorLabel.backgroundColor = UIColor.red
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
    }

}
