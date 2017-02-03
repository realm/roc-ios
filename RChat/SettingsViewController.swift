//
//  SettingsViewController.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Eureka

class SettingsViewController : FormViewController {

    lazy var profileRow : ProfileRow = {
        let row = ProfileRow()
        return row
    }()

    lazy var usernameRow : TextRow = {
        let row = TextRow() { row in
            row.title = "Username: "
        }
        row.disabled = Condition(booleanLiteral: true)
        return row
    }()

    lazy var displayNameRow : TextRow = {
        let row = TextRow() { row in
            row.title = "Display Name:"
        }
        return row
    }()

    lazy var saveButtonRow : ButtonRow = {
        let row = ButtonRow() { row in
            row.title = "Save Changes"
        }
        return row
    }()

    lazy var logoutButtonRow : ButtonRow = {
        let row = ButtonRow() { row in
            row.title = "Logout"
        }
        return row
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"

        form +++ Section()
            <<< profileRow
            <<< usernameRow
            <<< displayNameRow

        form +++ Section()
            <<< saveButtonRow

        form +++ Section()
            <<< logoutButtonRow
    }

}
