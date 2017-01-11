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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
