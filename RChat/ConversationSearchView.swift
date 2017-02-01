//
//  ConversationSearchView.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class ConversationSearchView : UIView, UITextFieldDelegate {

    lazy var iconButton : UIButton = {
        let i = UIButton()
        i.layer.cornerRadius = RChatConstants.Numbers.cornerRadius
        i.setImage(RChatConstants.Images.profileIcon, for: .normal)
        i.contentMode = .scaleAspectFit
        i.tintColor = UIColor.white
        i.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return i
    }()

    lazy var searchTextField : RTextField = {
        let t = RTextField()
        t.backgroundColor = RChatConstants.Colors.primaryColorDark
        t.layer.cornerRadius = RChatConstants.Numbers.cornerRadius
        t.layer.masksToBounds = true
        t.insetX = RChatConstants.Numbers.minorHorizontalSpacing
        t.textColor = .white
        t.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
            NSForegroundColorAttributeName : UIColor.lightGray,
            NSFontAttributeName: RChatConstants.Fonts.regularFont
        ])
        return t
    }()

    lazy var cancelButton : UIButton = {
        let b = UIButton()
        b.setTitle("Cancel", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        b.titleLabel?.font = RChatConstants.Fonts.regularFont
        return b
    }()

    let constraintGroup = ConstraintGroup()

    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = RChatConstants.Colors.primaryColor
        addSubview(iconButton)
        addSubview(searchTextField)
        addSubview(cancelButton)

        searchTextField.delegate = self
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTap(button:)), for: .touchUpInside)

        toggle(isEditing: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        toggle(isEditing: true, animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        toggle(isEditing: false, animated: true)
    }

    func cancelButtonDidTap(button: UIButton){
        searchTextField.resignFirstResponder()
    }

    func toggle(isEditing: Bool, animated: Bool = false){
        if isEditing {
            constrain(iconButton, searchTextField, cancelButton, replace: constraintGroup, block: { (iconButton, searchTextField, cancelButton) in
                iconButton.width == 33
                iconButton.height == 33
                iconButton.left == iconButton.superview!.left + RChatConstants.Numbers.horizontalSpacing
                iconButton.bottom == iconButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing

                cancelButton.right == cancelButton.superview!.right - RChatConstants.Numbers.horizontalSpacing
                cancelButton.height == 33
                cancelButton.width == 50
                cancelButton.bottom == cancelButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing

                searchTextField.left == searchTextField.superview!.left + RChatConstants.Numbers.horizontalSpacing
                searchTextField.right == cancelButton.left - RChatConstants.Numbers.horizontalSpacing
                searchTextField.bottom == cancelButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing
                searchTextField.height == 33
            })
        }else{
            constrain(iconButton, searchTextField, cancelButton, replace: constraintGroup, block: { (iconButton, searchTextField, cancelButton) in
                iconButton.width == 33
                iconButton.height == 33
                iconButton.left == iconButton.superview!.left + RChatConstants.Numbers.horizontalSpacing
                iconButton.bottom == iconButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing

                cancelButton.right == cancelButton.superview!.right - RChatConstants.Numbers.horizontalSpacing
                cancelButton.height == 33
                cancelButton.width == 50
                cancelButton.bottom == cancelButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing

                searchTextField.left == iconButton.right + RChatConstants.Numbers.minorHorizontalSpacing
                searchTextField.right == searchTextField.superview!.right - RChatConstants.Numbers.minorHorizontalSpacing
                searchTextField.bottom == cancelButton.superview!.bottom - RChatConstants.Numbers.verticalSpacing
                searchTextField.height == 33
            })
        }
        let imageViewNewAlpha: CGFloat = isEditing ? 0 : 1
        let cancelButtonNewAlpha: CGFloat = isEditing ? 1 : 0

        if animated {
            UIView.animate(withDuration: 0.25, animations: layoutIfNeeded)
            UIView.animate(withDuration: 0.25, animations: { 
                self.cancelButton.alpha = cancelButtonNewAlpha
                self.iconButton.alpha = imageViewNewAlpha
            })
        }else{
            self.cancelButton.alpha = cancelButtonNewAlpha
            self.iconButton.alpha = imageViewNewAlpha
            layoutIfNeeded()
        }
    }

}
