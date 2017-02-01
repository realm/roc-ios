//
//  ConversationsViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import SideMenu
import Cartography

class ConversationsViewController : UISideMenuNavigationController, UITableViewDataSource, UITableViewDelegate {

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

    var conversations : [Conversation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RChatConstants.Colors.primaryColorDark
        view.addSubview(tableView)
        view.addSubview(searchView)

        tableView.dataSource = self
        tableView.delegate = self

        let one = Conversation()
        one.displayName = "Engineering"

        let two = Conversation()
        two.displayName = "Marketing"

        conversations.append(one)
        conversations.append(two)

        tableView.reloadData()

        constrain(searchView, tableView) { (searchView, tableView) in
            searchView.left == searchView.superview!.left
            searchView.right == searchView.superview!.right
            searchView.height == 65
            searchView.top == searchView.superview!.top

            tableView.top == searchView.bottom
            tableView.left == tableView.superview!.left
            tableView.right == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
        _ = conversations[indexPath.row]
        dismiss(animated: true, completion: nil)
    }

}
