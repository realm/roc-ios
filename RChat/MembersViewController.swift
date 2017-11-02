//
//  MembersViewController.swift
//  RChat
//
//  Created by Max Alexander on 2/8/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift
import Cartography

protocol MembersViewControllerDelegate: class {
    func memberSelected(user: User)
}

class MembersViewController:
    UISideMenuNavigationController,
    UITableViewDataSource,
    UITableViewDelegate
{

    weak var membersViewControllerDelegate: MembersViewControllerDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.separatorInset = .zero
        tableView.contentInset = UIEdgeInsetsMake(80, 0, 300, 0)
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: MemberTableViewCell.REUSE_ID)
        tableView.rowHeight = MemberTableViewCell.HEIGHT
        return tableView
    }()

    var members: List<User>?
    var token : NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Members"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        constrain(tableView) { (tableView) in
            tableView.left == tableView.superview!.left
            tableView.right == tableView.superview!.right
            tableView.top == tableView.superview!.top
            tableView.bottom == tableView.superview!.bottom
        }
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.REUSE_ID, for: indexPath) as! MemberTableViewCell
        if let user = members?[indexPath.row] {
            cell.setupWithUser(user: user)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = members?[indexPath.row] else { return }
        membersViewControllerDelegate?.memberSelected(user: user)
        dismiss(animated: true, completion: nil)
    }

    func setupWithConversation(conversation: Conversation) {
        token?.invalidate()
        members = conversation.users
        token = conversation.users.observe({ [weak self] (changes) in
            guard let `self` = self else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
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
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        })
    }
}
