//
//  RChatMessageCollectionViewCellAvatarStyle.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions

class RChatMessageCollectionViewCellAvatarStyle: BaseMessageCollectionViewCellDefaultStyle {

    init(){
        let dateStyle = BaseMessageCollectionViewCellDefaultStyle.DateTextStyle(font: RChatConstants.Fonts.regularFont, color: UIColor.darkGray)
        super.init(dateTextStyle: dateStyle)
    }

    override func avatarSize(viewModel: MessageViewModelProtocol) -> CGSize {
        // Display avatar for both incoming and outgoing messages for demo purpose
        return CGSize(width: 35, height: 35)
    }
    
}
