//
//  RChatButton.swift
//  RChat
//
//  Created by Max Alexander on 1/20/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

class RChatButton : UIButton {

    init(){
        super.init(frame: .zero)
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        layer.backgroundColor = RChatConstants.Colors.primaryColor.cgColor
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .disabled)
        titleLabel?.font = RChatConstants.Fonts.boldFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
