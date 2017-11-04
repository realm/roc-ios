//
//  RChatTextMessageHandler.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions

class RChatTextMessageHandler: BaseMessageInteractionHandlerProtocol {
    private let baseHandler: RChatBaseMessageHandler
    init (baseHandler: RChatBaseMessageHandler) {
        self.baseHandler = baseHandler
    }

    func userDidTapOnFailIcon(viewModel: RChatTextMessageViewModel, failIconView: UIView) {
        self.baseHandler.userDidTapOnFailIcon(viewModel: viewModel)
    }

    func userDidTapOnAvatar(viewModel: RChatTextMessageViewModel) {
        self.baseHandler.userDidTapOnAvatar(viewModel: viewModel)
    }

    func userDidTapOnBubble(viewModel: RChatTextMessageViewModel) {
        self.baseHandler.userDidTapOnBubble(viewModel: viewModel)
    }

    func userDidBeginLongPressOnBubble(viewModel: RChatTextMessageViewModel) {
        self.baseHandler.userDidBeginLongPressOnBubble(viewModel: viewModel)
    }

    func userDidEndLongPressOnBubble(viewModel: RChatTextMessageViewModel) {
        self.baseHandler.userDidEndLongPressOnBubble(viewModel: viewModel)
    }
}
