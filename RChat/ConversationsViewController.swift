//
//  ConversationsViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/9/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import SideMenu

class ConversationsViewController : UISideMenuNavigationController {

    lazy var tableView : UITableView = {
        let t = UITableView()
        t.backgroundColor = RChatConstants.Colors.midnightBlue
        t.translatesAutoresizingMaskIntoConstraints = false
        t.separatorColor = .clear
        return t
    }()

    lazy var searchView : ConversationSearchView = {
        let c = ConversationSearchView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RChatConstants.Colors.wetAsphalt
        view.addSubview(tableView)
        view.addSubview(searchView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[searchView]-0-|", options: [], metrics: nil, views: ["searchView": searchView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[searchView(65)]-0-[tableView]-0-|", options: [], metrics: nil, views: ["tableView": tableView, "searchView": searchView]))
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
