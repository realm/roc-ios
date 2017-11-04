//
//  RChatImageMessageViewModelBuilder.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions
import SDWebImage

class RChatImageMessageViewModelBuilder: ViewModelBuilderProtocol {
    init() {}

    let messageViewModelBuilder = MessageViewModelDefaultBuilder()

    func createViewModel(_ message: RChatImageMessageModel) -> RChatImageMessageViewModel {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(message)
        let imageMessageViewModel = RChatImageMessageViewModel(photoMessage: message, messageViewModel: messageViewModel)
        return imageMessageViewModel
    }

    func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is RChatImageMessageModel
    }
    
}
