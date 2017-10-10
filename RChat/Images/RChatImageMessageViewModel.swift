//
//  RChatTextMessageViewModel.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions
import SDWebImage


class RChatImageMessageViewModel: PhotoMessageViewModel<RChatImageMessageModel>, RChatMessageViewModelProtocol {
    override init(photoMessage: RChatImageMessageModel, messageViewModel: MessageViewModelProtocol) {
        super.init(photoMessage: photoMessage, messageViewModel: messageViewModel)
    }
    
    var messageModel: RChatMessageModelProtocol {
        return self.messageModel
    }

}


