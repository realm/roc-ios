//
//  MembersTableViewCell.swift
//  RChat
//
//  Created by Max Alexander on 2/8/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class MemberTableViewCell: UITableViewCell {

    static let REUSE_ID = "MemberTableViewCell"
    static let HEIGHT: CGFloat = 44

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
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
}
