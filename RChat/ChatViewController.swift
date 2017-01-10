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

class ChatViewController : BaseChatViewController, RChatInputViewDelegate {

    let chatInputView = RChatInputView()
    let messageHandler = RChatBaseMessageHandler()

    let conversationId : String

    init(conversationId : String) {
        self.conversationId = conversationId
        super.init(nibName: nil, bundle: nil)
        self.chatDataSource = RChatDataSource(conversationId: conversationId)
        self.chatItemsDecorator = RChatDecorator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = {
            let barButtonItem = UIBarButtonItem(image: RChatConstants.Images.menuIcon, style: .plain, target: self, action: #selector(ChatViewController.menuTapped))
            barButtonItem.tintColor = RChatConstants.Colors.peterRiver
            return barButtonItem
        }()

        chatInputView.delegate = self
    }

    override func createChatInputView() -> UIView {
        return chatInputView
    }

    override func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = ChatCollectionViewLayout()
        layout.delegate = self
        return layout
    }

    override func createPresenterBuilders() -> [ChatItemType : [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: RChatTextMessageViewModelBuilder(),
            interactionHandler: RChatTextMessageHandler(baseHandler: self.messageHandler)
        )
        textMessagePresenter.baseMessageStyle = {
            let style = RChatMessageCollectionViewCellAvatarStyle()
            return style
        }()
        textMessagePresenter.textCellStyle = RChatTextMessageCollectionViewCellStyle()
        return [
            MimeType.textPlain.rawValue: [textMessagePresenter],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
        ]
    }

    func menuTapped(){

    }

    func attachmentButtonDidTapped() {

    }

    func sendMessage(text: String) {
        let dataSource = chatDataSource as! RChatDataSource
        dataSource.sendMessage(text: text)

    }
}
