//
//  RChatBaseMessageHandler.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class RChatBaseMessageHandler {

    func userDidTapOnFailIcon(viewModel: RChatMessageViewModelProtocol) {

    }

    func userDidTapOnAvatar(viewModel: RChatMessageViewModelProtocol) {
    }

    func userDidTapOnBubble(viewModel: RChatMessageViewModelProtocol) {
        print("userDidTapOnBubble")
    }

    func userDidBeginLongPressOnBubble(viewModel: RChatMessageViewModelProtocol) {
        print("userDidBeginLongPressOnBubble")
    }

    func userDidEndLongPressOnBubble(viewModel: RChatMessageViewModelProtocol) {
        print("userDidEndLongPressOnBubble")
    }
}
