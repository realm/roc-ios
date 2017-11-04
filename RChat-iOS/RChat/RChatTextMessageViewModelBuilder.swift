//
//  RChatTextMessageViewModelBuilder.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions
import SDWebImage

class RChatTextMessageViewModelBuilder: ViewModelBuilderProtocol {
    init() {}

    let messageViewModelBuilder = MessageViewModelDefaultBuilder()

    func createViewModel(_ textMessage: RChatTextMessageModel) -> RChatTextMessageViewModel {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(textMessage)
        let textMessageViewModel = RChatTextMessageViewModel(textMessage: textMessage, messageViewModel: messageViewModel)
        return textMessageViewModel
    }

    func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is RChatTextMessageModel
    }
    
}
