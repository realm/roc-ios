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

class MembersViewController: UISideMenuNavigationController {

    weak var membersViewControllerDelegate: MembersViewControllerDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    var members: Results<User>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Member"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
