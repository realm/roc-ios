//
//  SearchResultsViewController.swift
//  RChat
//
//  Created by Max Alexander on 2/8/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift

protocol SearchResultsViewControllerDelegate : class {
    func selectedSearchedConversation(conversation: Conversation)
}

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: SearchResultsViewControllerDelegate?

    var conversations : Results<Conversation>?
    var users: Results<User>?
    var chats: Results<ChatMessage>?

    lazy var tableView : UITableView = {
        let t = UITableView()
        t.separatorInset = .zero
        t.separatorColor = .clear
        t.backgroundColor = RChatConstants.Colors.primaryColorDark
        t.keyboardDismissMode = .interactive
        t.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.REUSE_ID)
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        constrain(tableView) { (tableView) in
            tableView.left == tableView.superview!.left
            tableView.right == tableView.superview!.right
            tableView.top == tableView.superview!.top
            tableView.bottom == tableView.superview!.bottom
        }

        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3    // Was 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return conversations?.count ?? 0
        case 1:
            return users?.count ?? 0
            
        // Added support for searching inside chats
        case 2:
            return chats?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.REUSE_ID, for: indexPath) as! SearchResultTableViewCell

        switch indexPath.section {
        case 0:
            if let conversation = conversations?[indexPath.row] {
                cell.setupWithConversation(conversation: conversation)
            }
        case 1:
            if let user = users?[indexPath.row] {
                cell.setupWithUser(user: user)
            }
            
        // Added support for searching inside chats
        case 2:
            if let chat = chats?[indexPath.row] {
                cell.setupWithChat(chat: chat)
            }
        default:
            fatalError("No such section exists")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result: String?
        switch section {
        case 0:
            result =  "Conversations"
        case 1: // users
            result =  "Users"
        case 2:
            result =  "Chats"
        default:
            result =  "Unknown Section!"
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if let conversation = conversations?[indexPath.row] {
                delegate?.selectedSearchedConversation(conversation: conversation)
            }
            return;
        case 1:
            if let user = users?[indexPath.row] {
                var mutableUsers = [User]()
                mutableUsers.append(user)
                mutableUsers.append(User.getMe()) // lets add me
                let conversation = Conversation.putConversation(users: mutableUsers)
                delegate?.selectedSearchedConversation(conversation: conversation)
            }
            return;
            
        // Added support for searching inside chats
        case 2:
            if let chat = chats?[indexPath.row] {
                let realm = RChatConstants.Realms.global
                let conversation = realm.objects(Conversation.self).filter("conversationId = %@", chat.conversationId).first
                delegate?.selectedSearchedConversation(conversation: conversation!)
            }
            return;

        default:
            fatalError("No such section exists")
        }
    }

    func searchConversationsAndUsers(searchTerm: String){
        conversations = Conversation.searchForConversations(searchTerm: searchTerm)
        users = User.searchForUsers(searchTerm: searchTerm)

        // Added support for searching inside chats
        chats = ChatMessage.searchInChats(searchTerm: searchTerm)

        tableView.reloadData()
    }

}
