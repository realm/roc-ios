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

class ChatViewController : BaseChatViewController,
    RChatInputViewDelegate,
    ConversationsViewControllerDelegate,
    MembersViewControllerDelegate
{

    let chatInputView = RChatInputView()
    let messageHandler = RChatBaseMessageHandler()
    var conversation: Conversation
    var viewModel : ChatViewModel {
        return self.chatDataSource as! ChatViewModel
    }

    init(conversation : Conversation = Conversation.generateDefaultConversation()) {
        self.conversation = conversation
        super.init(nibName: nil, bundle: nil)
        self.chatDataSource = ChatViewModel()
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
            let barButtonItem = UIBarButtonItem(image: RChatConstants.Images.menuIcon, style: .plain, target: self, action: #selector(ChatViewController.menuBarButtonTapped))
            barButtonItem.tintColor = .white
            return barButtonItem
        }()
        navigationItem.rightBarButtonItem = {
            let barButtonItem = UIBarButtonItem(image: RChatConstants.Images.verticalMoreIcon, style: .plain, target: self, action: #selector(ChatViewController.membersBarButtonTapped))
            barButtonItem.tintColor = .white
            return barButtonItem
        }()

        chatInputView.delegate = self
        viewModel.conversation = conversation

        SideMenuManager.menuLeftNavigationController = {
            let conversationsViewController = ConversationsViewController()
            conversationsViewController.leftSide = true
            conversationsViewController.conversationsViewControllerDelegate = self
            return conversationsViewController
        }()
        SideMenuManager.menuRightNavigationController = {
            let membersViewController = MembersViewController()
            membersViewController.leftSide = false
            membersViewController.membersViewControllerDelegate = self
            return membersViewController
        }()

        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuWidth = max(round(min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.85), 240)
        SideMenuManager.menuShadowOpacity = 0
        SideMenuManager.menuAnimationPresentDuration = 0.25
        SideMenuManager.menuAnimationDismissDuration = 0.25
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.view)

        viewModel.defaultingNameCallback = { [weak self] defaultingName in
            guard let `self` = self else { return }
            self.title = defaultingName
        }

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

    func menuBarButtonTapped(){
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }

    func membersBarButtonTapped(){
        present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
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
        viewModel.sendMessage(text: text)
    }

    // ConversationsViewControllerDelegate
    func changeConversation(conversation: Conversation) {
        viewModel.conversation = conversation
    }

    func goToProfile() {
        removeBackButtonTitle()
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

    // MembersViewControllerDelegate
    func memberSelected(user: User) {

    }
}
