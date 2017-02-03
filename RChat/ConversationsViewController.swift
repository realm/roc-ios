//
//  ConversationsViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift
import Cartography


protocol ConversationsViewControllerDelegate: class {
    func changeConversation(conversation: Conversation)
    func goToProfile()
}

class ConversationsViewController : UISideMenuNavigationController,
    UITableViewDataSource,
    UITableViewDelegate,
    ComposeViewControllerDelegate
{

    weak var conversationsViewControllerDelegate: ConversationsViewControllerDelegate?

    lazy var tableView : UITableView = {
        let t = UITableView()
        t.backgroundColor = RChatConstants.Colors.midnightBlue
        t.translatesAutoresizingMaskIntoConstraints = false
        t.separatorColor = .clear
        t.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.REUSE_ID)
        t.rowHeight = ConversationTableViewCell.HEIGHT
        return t
    }()

    lazy var searchView : ConversationSearchView = {
        let c = ConversationSearchView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    lazy var penButton : UIButton = {
        let b = UIButton()
        b.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        b.imageView?.contentMode = .scaleAspectFit
        b.layer.cornerRadius = 44 / 2
        b.layer.masksToBounds = true
        b.tintColor = .white
        b.setImage(RChatConstants.Images.penIcon, for: .normal)
        b.backgroundColor = RChatConstants.Colors.primaryColor
        return b
    }()

    var conversations : Results<Conversation>!
    var notificationToken : NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RChatConstants.Colors.primaryColorDark
        view.addSubview(tableView)
        view.addSubview(searchView)
        view.addSubview(penButton)

        penButton.addTarget(self, action: #selector(ConversationsViewController.penButtonDidTap(button:)), for: .touchUpInside)
        searchView.iconButton.addTarget(self, action: #selector(ConversationsViewController.profileIconButtonDidTap(button:)), for: .touchUpInside)

        tableView.dataSource = self
        tableView.delegate = self

        constrain(searchView, tableView, penButton) { (searchView, tableView, penButton) in
            searchView.left == searchView.superview!.left
            searchView.right == searchView.superview!.right
            searchView.height == 65
            searchView.top == searchView.superview!.top

            tableView.top == searchView.bottom
            tableView.left == tableView.superview!.left
            tableView.right == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom

            penButton.width == 44
            penButton.height == 44
            penButton.right == penButton.superview!.right - RChatConstants.Numbers.horizontalSpacing
            penButton.bottom == penButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing
        }

        let realm = RChatConstants.Realms.conversations
        let predicate = NSPredicate(format: "ANY users.userId = %@", RChatConstants.myUserId)
        conversations = realm.objects(Conversation.self).filter(predicate)

        notificationToken = conversations
            .addNotificationBlock { [weak self] (changes) in
                guard let `self` = self else { return }
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                    break
                case .update(_, let deletions, let insertions, let modifications):
                    // Query results have changed, so apply them to the UITableView
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    self.tableView.endUpdates()
                    break
                case .error(let error):
                    fatalError(error.localizedDescription)
                    break
                }
            }

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func penButtonDidTap(button: UIButton){
        let controller = CustomNavController(rootViewController: ComposeViewController())
        present(controller, animated: true, completion: nil)
    }

    func profileIconButtonDidTap(button: UIButton) {
        dismiss(animated: true, completion: nil)
        conversationsViewControllerDelegate?.goToProfile()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.REUSE_ID, for: indexPath) as! ConversationTableViewCell
        let conversation = conversations[indexPath.row]
        cell.setupWithConversation(conversation: conversation)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversation = conversations[indexPath.row]
        conversationsViewControllerDelegate?.changeConversation(conversation: conversation)
        dismiss(animated: true, completion: nil)
    }

    func composeWithUsers(users: [User]) {
        let conversation = Conversation.putConversation(users: users)
        conversationsViewControllerDelegate?.changeConversation(conversation: conversation)
        dismiss(animated: true, completion: nil)
    }

    deinit {
        notificationToken?.stop()
    }
}
