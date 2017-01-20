//
//  WelcomeViewController.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

class WelcomeViewController : UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


        if (RChatConstants.isLoggedIn){
            navigationController?.setViewControllers([LoginViewControler()], animated: true)
        }else{
            navigationController?.setViewControllers([ChatViewController()], animated: true)
        }
    }

}
