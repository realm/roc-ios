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
import SideMenu

class ChatViewController : BaseChatViewController, RChatInputViewDelegate {

    let chatInputView = RChatInputView()
    let messageHandler = RChatBaseMessageHandler()

    let conversationId : String

    init(conversationId : String) {
        self.conversationId = conversationId
        super.init(nibName: nil, bundle: nil)
        self.chatDataSource = RChatDataSource()
        self.chatItemsDecorator = RChatDecorator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = {
            let barButtonItem = UIBarButtonItem(image: RChatConstants.Images.menuIcon, style: .plain, target: self, action: #selector(ChatViewController.menuTapped))
            barButtonItem.tintColor = .white
            return barButtonItem
        }()

        chatInputView.delegate = self

        SideMenuManager.menuLeftNavigationController = {
            let conversationsViewController = ConversationsViewController()
            conversationsViewController.leftSide = true
            return conversationsViewController
        }()
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuWidth = max(round(min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.85), 240)
        SideMenuManager.menuShadowOpacity = 0
        SideMenuManager.menuAnimationPresentDuration = 0.25
        SideMenuManager.menuAnimationDismissDuration = 0.25

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
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }

    func attachmentButtonDidTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] (_) in
            self?.presentCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Library", style: .default, handler: { [weak self] (_) in
            self?.presentPhotoLibrary()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in

        }))
        present(alertController, animated: true, completion: nil)
    }

    func sendMessage(text: String) {
        let dataSource = chatDataSource as! RChatDataSource
        dataSource.sendMessage(text: text)

    }
}
