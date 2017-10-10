//
//  RChatImageMessageModel.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import ChattoAdditions

class RChatImageMessageModel: PhotoMessageModel<ChatMessage>, RChatMessageModelProtocol {
    override init(messageModel: ChatMessage, imageSize: CGSize, image: UIImage) {
        super.init(messageModel: messageModel, imageSize:CGSize(width:256, height:256), image: UIImage(data: messageModel.extraInfo! as Data)!)
    }
    var status: MessageStatus {
        get {
            return self._messageModel.status
        }
        set {
            // self._messageModel.status = newValue
            //
        }
    }

}


//class RChatImageMessageModel: TextMessageModel<ChatMessage>, RChatMessageModelProtocol {
//    init(messageModel: ChatMessage){
//        super.init(messageModel: messageModel, text: messageModel.text)
//    }
//
//    var status: MessageStatus {
//        get {
//            return self._messageModel.status
//        }
//        set {
//            // self._messageModel.status = newValue
//            //
//        }
//    }
//}

