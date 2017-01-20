//
//  LoginViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Eureka

class LoginViewControler : FormViewController {


    lazy var usernameRow : TextRow = {
        let row = TextRow()
        row.title = "Username"
        return row
    }()

    lazy var passwordRow : TextRow = {
        let row = TextRow()
        row.title = "Password"
        return row
    }()

    lazy var loginButtonRow : ButtonRow = {
        let row = ButtonRow()
        row.title = "Login"
        return row
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section()
            <<< usernameRow
            <<< passwordRow

        form +++ Section()
            <<< loginButtonRow
    }

}
