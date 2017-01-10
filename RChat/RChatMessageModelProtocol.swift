//
//  RChatMessageModelProtocol.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

protocol RChatMessageModelProtocol: MessageModelProtocol {
    var status: MessageStatus { get set }
}
