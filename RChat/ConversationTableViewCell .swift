//
//  ConversationTableViewCell .swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

class ConversationTableViewCell : UITableViewCell {

    static let REUSE_ID = "ConversationTableViewCell"
    static let HEIGHT : CGFloat = 45

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        textLabel?.textColor = UIColor.white
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[textLabel]-16-|", options: [], metrics: nil, views: ["textLabel": textLabel!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[textLabel]-0-|", options: [], metrics: nil, views: ["textLabel": textLabel!]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithConversation(conversation: Conversation){
        textLabel?.text = conversation.defaultingName
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
    }

}
