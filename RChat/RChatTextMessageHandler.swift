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
    private let baseHandler: BaseMessageHandler
    init (baseHandler: BaseMessageHandler) {
        self.baseHandler = baseHandler
    }

    func userDidTapOnFailIcon(viewModel: EdenTextMessageViewModel, failIconView: UIView) {
        self.baseHandler.userDidTapOnFailIcon(viewModel: viewModel)
    }

    func userDidTapOnAvatar(viewModel: EdenTextMessageViewModel) {
        self.baseHandler.userDidTapOnAvatar(viewModel: viewModel)
    }

    func userDidTapOnBubble(viewModel: EdenTextMessageViewModel) {
        self.baseHandler.userDidTapOnBubble(viewModel: viewModel)
    }

    func userDidBeginLongPressOnBubble(viewModel: EdenTextMessageViewModel) {
        self.baseHandler.userDidBeginLongPressOnBubble(viewModel: viewModel)
    }

    func userDidEndLongPressOnBubble(viewModel: EdenTextMessageViewModel) {
        self.baseHandler.userDidEndLongPressOnBubble(viewModel: viewModel)
    }
}
