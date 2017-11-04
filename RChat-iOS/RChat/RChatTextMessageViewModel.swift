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

class RChatTextMessageViewModel: TextMessageViewModel<RChatTextMessageModel>, RChatMessageViewModelProtocol {

    override init(textMessage: RChatTextMessageModel, messageViewModel: MessageViewModelProtocol) {
        super.init(textMessage: textMessage, messageViewModel: messageViewModel)

        /* This is some logic for loading the UserAvatar
        let userId = textMessage.senderId
        guard let spriteUrl = User.getByUserId(userId: userId)?.spriteUrl else {
            return
        }
        SDWebImageManager.shared().downloadImage(with: URL(string: spriteUrl)!, options: [], progress: nil) { [weak self] (image, err, _, _, _) in
            if let image = image {
                self?.avatarImage.value = image
            }else {
                self?.avatarImage.value = UIImage(named: "sample_sprite")
            }
        }
         */
    }

    var messageModel: RChatMessageModelProtocol {
        return self.textMessage
    }

}

class EdenTextMessageViewModelBuilder: ViewModelBuilderProtocol {
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
