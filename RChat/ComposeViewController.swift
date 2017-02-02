//
//  ComposeViewController.swift
//  RChat
//
//  Created by Max Alexander on 2/1/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import TURecipientBar
import Cartography

protocol ComposeViewControllerDelegate : class {
    func composeWithUsers(users: [User])
}

class ComposeViewController: UIViewController, TURecipientsBarDelegate, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: ComposeViewControllerDelegate?

    lazy var recipientBar : RChatRecipientBar = {
        let recipientBar = RChatRecipientBar()
        return recipientBar
    }()

    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ComposeUserTableViewCell.self, forCellReuseIdentifier: ComposeUserTableViewCell.REUSE_ID)
        tableView.rowHeight = ComposeUserTableViewCell.HEIGHT
        return tableView
    }()

    lazy var doneButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ComposeViewController.doneButtonDidTap(button:)))
        return button
    }()

    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(recipientBar)
        view.addSubview(tableView)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ComposeViewController.cancelDidTap(button:)))
        recipientBar.recipientsBarDelegate = self
        title = "New Message"

        tableView.delegate = self
        tableView.dataSource = self

        constrain(recipientBar, tableView) { (recipientBar, tableView) in
            recipientBar.left == recipientBar.superview!.left
            recipientBar.right == recipientBar.superview!.right
            recipientBar.top == recipientBar.superview!.top
            recipientBar.height >= 45

            tableView.left == tableView.superview!.left
            tableView.right == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
            tableView.top == recipientBar.bottom
        }
    }

    func cancelDidTap(button: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }

    func doneButtonDidTap(button: UIBarButtonItem){
        let users = recipientBar.users
        var mutableUsers = [User]()
        mutableUsers.append(contentsOf: users)
        mutableUsers.append(User.getMe()) // lets add me
        dismiss(animated: true) { 
            self.delegate?.composeWithUsers(users: mutableUsers)
        }
    }

    func recipientsBar(_ recipientsBar: TURecipientsBar, textDidChange searchText: String?) {
        let searchTextNonOptional = searchText ?? ""
        let users = User.searchForUsers(searchTerm: searchTextNonOptional)
        self.users = Array(users)
        self.tableView.reloadData()
    }

    func recipientsBar(_ recipientsBar: TURecipientsBar, didAdd recipient: TURecipientProtocol) {
        evaluateDoneButton()
        recipientsBar.text = ""
    }

    func recipientsBar(_ recipientsBar: TURecipientsBar, didRemove recipient: TURecipientProtocol) {
        evaluateDoneButton()
    }

    func evaluateDoneButton(){
        navigationItem.rightBarButtonItem = recipientBar.users.count == 0 ? nil : doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComposeUserTableViewCell.REUSE_ID, for: indexPath) as! ComposeUserTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.displayName
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let user = users[indexPath.row]
        if recipientBar.containsUser(user: user) {
            recipientBar.removeUser(user: user)
        } else {
            recipientBar.addUser(user: user)
        }
    }
}
