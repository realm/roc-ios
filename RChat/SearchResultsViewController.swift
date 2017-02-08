//
//  SearchResultsViewController.swift
//  RChat
//
//  Created by Max Alexander on 2/8/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var conversations: [Conversation] = []
    var users: [User] = []

    lazy var tableView : UITableView = {
        let t = UITableView()
        t.separatorInset = .zero
        t.separatorColor = .clear
        t.backgroundColor = RChatConstants.Colors.primaryColorDark
        t.keyboardDismissMode = .interactive
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
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
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return conversations.count
        case 1:
            return users.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.REUSE_ID, for: indexPath) as! SearchResultTableViewCell
        return cell
    }

    func searchConversationsAndUsers(searchTerm: String){

    }

}
