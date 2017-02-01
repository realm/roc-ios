//
//  RChatRecipientBar.swift
//  RChat
//
//  Created by Max Alexander on 2/1/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import TURecipientBar


class RChatRecipientBar : TURecipientsBar {

    var users : [User] {
        return userRecipients.map({ $0.user })
    }

    var userRecipients : [UserRecipient] {
        var array = [UserRecipient]()
        for recipient in self.recipients {
            if let userRecipient = recipient as? UserRecipient {
                array.append(userRecipient)
            }
        }
        return array
    }

    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func commonInit() {

    }

    func addUser(user: User){
        if userRecipients.contains(where: { $0.user.userId == user.userId }) {
            return
        }
        addRecipient(UserRecipient(user: user))
    }

    func removeUser(user: User){
        removeByUserId(userId: user.userId)
    }

    func removeByUserId(userId: String){
        guard let foundRecipient = userRecipients.filter({ $0.user.userId == userId }).first else { return }
        removeRecipient(foundRecipient)
    }

    func containsUser(user: User) -> Bool {
        return userRecipients.contains(where: { $0.user.userId == user.userId })
    }

}

class UserRecipient : NSObject, NSCopying, TURecipientProtocol {

    public var recipientTitle: String {
        return user.displayName
    }

    let user: User

    init(user: User){
        self.user = user
        super.init()
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        return UserRecipient(user: self.user)
    }

}
