//
//  WelcomeViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

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

    lazy var launchLogoImageView : UIImageView = {
        let i = UIImageView()
        i.image = RChatConstants.Images.launchLogo
        i.tintColor = .white
        return i
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
        view.addSubview(launchLogoImageView)

        loginButton.addTarget(self, action: #selector(loginButtonDidTap(button:)), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonDidTap(button:)), for: .touchUpInside)

        constrain(loginButton, registerButton, launchLogoImageView) { (loginButton, registerButton, launchLogoImageView) in

            loginButton.left == loginButton.superview!.left + RChatConstants.Numbers.horizontalSpacing
            loginButton.height == 50
            loginButton.bottom == loginButton.superview!.bottom - RChatConstants.Numbers.majorVerticalSpacing
            loginButton.right == loginButton.superview!.centerX - RChatConstants.Numbers.minorHorizontalSpacing

            registerButton.left == registerButton.superview!.centerX + RChatConstants.Numbers.minorHorizontalSpacing
            registerButton.height == 50
            registerButton.bottom == registerButton.superview!.bottom - RChatConstants.Numbers.majorVerticalSpacing
            registerButton.right == registerButton.superview!.right - RChatConstants.Numbers.horizontalSpacing

            launchLogoImageView.height == 100
            launchLogoImageView.width == 100
            launchLogoImageView.centerX == launchLogoImageView.superview!.centerX
            launchLogoImageView.centerY == launchLogoImageView.superview!.centerY

        }
    }

}
