//
//  ProfileImageRow.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography
import Eureka


final class ProfileCell : Cell<UIImage>, CellType {

    private static let IMAGE_VIEW_LENGTH : CGFloat = 100

    lazy var profileImageView : UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = IMAGE_VIEW_LENGTH / 2
        i.layer.borderColor = RChatConstants.Colors.silver.cgColor
        i.layer.borderWidth = 2
        i.backgroundColor = RChatConstants.Colors.asbestos
        i.layer.masksToBounds  = true
        return i
    }()


    override func setup() {
        super.setup()
        height = { 120 }
        contentView.addSubview(profileImageView)
        constrain(profileImageView) { (profileImageView) in
            profileImageView.centerX == profileImageView.superview!.centerX
            profileImageView.centerY == profileImageView.superview!.centerY
            profileImageView.width == ProfileCell.IMAGE_VIEW_LENGTH
            profileImageView.height == ProfileCell.IMAGE_VIEW_LENGTH
        }
    }
    
    override func update() {
        super.update()
        profileImageView.image = row.value
    }


}

final class ProfileRow : Row<ProfileCell>, RowType {

    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<ProfileCell>()
    }
}
