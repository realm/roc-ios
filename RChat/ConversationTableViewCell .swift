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
        label.backgroundColor = .red
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
        contentView.addSubview(unreadIndicatorLabel)

        constrain(textLabel!, unreadIndicatorLabel) { (textLabel, unreadIndicatorLabel) in
            unreadIndicatorLabel.right == unreadIndicatorLabel.superview!.right - RChatConstants.Numbers.horizontalSpacing
            unreadIndicatorLabel.height == 33
            unreadIndicatorLabel.width == 33
            unreadIndicatorLabel.centerY == unreadIndicatorLabel.superview!.centerY

            textLabel.left == textLabel.superview!.left + RChatConstants.Numbers.horizontalSpacing
            textLabel.top == textLabel.superview!.top
            textLabel.bottom == textLabel.superview!.bottom
            textLabel.right == unreadIndicatorLabel.left - RChatConstants.Numbers.minorHorizontalSpacing
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithConversation(conversation: Conversation){
        textLabel?.text = conversation.defaultingName
        textLabel?.font = conversation.unreadCount > 0 ? RChatConstants.Fonts.boldFont : RChatConstants.Fonts.regularFont
        unreadIndicatorLabel.text = "\(conversation.unreadCount)"
        unreadIndicatorLabel.isHidden = conversation.unreadCount == 0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
    }

}
