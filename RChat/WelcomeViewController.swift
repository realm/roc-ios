//
//  WelcomeViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

class WelcomeViewController : UIViewController {

    lazy var loginButton : RChatButton = {
        let b = RChatButton()
        b.setTitle("Login", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    lazy var registerButton : RChatButton = {
        let b = RChatButton()
        b.setTitle("Register", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    let viewModel = WelcomeViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RChatConstants.Colors.primaryColorDark
        setupSubviewsAndLayout()
        // FROM VIEWMODEL
        viewModel.isAlreadyLoggedIn = { [weak self] isAlreadyLogged in
            if(isAlreadyLogged){
                self?.navigationController?.setViewControllers([ChatViewController(conversationId: "")], animated: true)
            }
        }

        viewModel.goToLogin = { [weak self] in
            self?.navigationController?.pushViewController(LoginViewControler(mode:.login), animated: true)
        }

        viewModel.goToSignup = { [weak self] in
            self?.navigationController?.pushViewController(LoginViewControler(mode:.signup), animated: true)
        }
    }

    func loginButtonDidTap(button: UIButton){
        viewModel.loginDidTap()
    }

    func registerButtonDidTap(button: UIButton){
        viewModel.registerDidTap()
    }

}

extension WelcomeViewController  {

    func setupSubviewsAndLayout(){
        navigationItem.backBarButtonItem = nil
        
        view.addSubview(loginButton)
        view.addSubview(registerButton)

        loginButton.addTarget(self, action: #selector(loginButtonDidTap(button:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonDidTap(button:)), for: .touchUpInside)

        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 16))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: -16))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -16))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))

        view.addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 16))
        view.addConstraint(NSLayoutConstraint(item: registerButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -16))
        view.addConstraint(NSLayoutConstraint(item: registerButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -16))
        view.addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
    }

}
