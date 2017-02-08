//
//  UIViewController+Extensions.swift
//  RChat
//
//  Created by Max Alexander on 2/3/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

extension UIViewController {

    // This gets rid of the backBarButtonItem's title for FUTURE pushed viewcontrollers
    func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
