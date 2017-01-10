//
//  ChatViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class ChatViewController : BaseChatViewController {

    let conversationId : String

    init(conversationId : String) {
        self.conversationId = conversationId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

}
