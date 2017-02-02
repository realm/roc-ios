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
        row.cellSetup({ (cell, row) in
            cell.textField.autocapitalizationType = .none
        })
        return row
    }()

    lazy var passwordRow : PasswordRow = {
        let row = PasswordRow()
        row.title = "Password"
        return row
    }()

    lazy var buttonRow : ButtonRow = {
        let row = ButtonRow()
        row.title = "Login"
        return row
    }()


    let viewModel : LoginViewModel

    init(mode: LoginViewModel.Mode){
        viewModel = LoginViewModel(mode: mode)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"

        form +++ Section()
            <<< usernameRow
            <<< passwordRow

        form +++ Section()
            <<< buttonRow


        // TO VIEWMODEL
        usernameRow.onChange { [weak self] (r) in
            self?.viewModel.username = r.value ?? ""
        }

        passwordRow.onChange { [weak self] (r) in
            self?.viewModel.password = r.value ?? ""
        }

        buttonRow.onCellSelection { [weak self] (_, _) in
            if self?.viewModel.mode == .login {
                self?.viewModel.attemptLogin()
            }
            if self?.viewModel.mode == .signup {
                self?.viewModel.attemptRegistration()
            }
        }

        // FROM VIEWMODEL
        viewModel.isProcessingCallback = { [weak self] isProcessing in
            self?.buttonRow.disabled = Condition(booleanLiteral: isProcessing)
            self?.buttonRow.reload()
        }

        viewModel.authErrorCallback = { [weak self] errorMessage in
            let alertViewController = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self?.present(alertViewController, animated: true, completion: nil)
        }

        viewModel.authSuccessCallback = { [weak self] _ in
            self?.navigationController?.setViewControllers([ChatViewController()], animated: true)
        }

        viewModel.modeCallback = { [weak self] mode in
            self?.title = mode == .login ? "Login" : "Signup"
            self?.buttonRow.title = mode == .login ? "Login" : "Signup"
            self?.buttonRow.reload()
        }
    }

}
