//
//  RChatCollectionViewLayout.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class RChatCollectionViewLayout: ChatCollectionViewLayout {


    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)

        attributes?.center = CGPoint(x: 0, y: 0)
        attributes?.alpha = 0


        return attributes
    }
}
