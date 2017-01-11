//
//  ConversationSearchView.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit


class ConversationSearchView : UIView {

    lazy var iconImageView : UIImageView = {
        let i = UIImageView()
        return i
    }()

    lazy var searchTextView : UITextField = {
        let t = UITextField()
        return t
    }()

    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = RChatConstants.Colors.wetAsphalt
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
