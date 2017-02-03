//
//  CustomNavController.swift
//  RChat
//
//  Created by Max Alexander on 2/1/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

class CustomNavController : UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = RChatConstants.Colors.primaryColorDark
        navigationBar.isOpaque = true
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white
        ]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
