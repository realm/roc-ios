//
//  ComposeUserTableViewCell.swift
//  RChat
//
//  Created by Max Alexander on 2/1/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class ComposeUserTableViewCell : UITableViewCell {

    static let REUSE_ID = "ComposeUserTableViewCell"
    static let HEIGHT : CGFloat = 45

    lazy var nameLabel : UILabel = {
        let n = UILabel()
        return n
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        constrain(nameLabel) { (nameLabel) in
            nameLabel.left == nameLabel.superview!.left + RChatConstants.Numbers.horizontalSpacing
            nameLabel.right == nameLabel.superview!.right - RChatConstants.Numbers.horizontalSpacing
            nameLabel.top == nameLabel.superview!.top
            nameLabel.bottom == nameLabel.superview!.bottom
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
