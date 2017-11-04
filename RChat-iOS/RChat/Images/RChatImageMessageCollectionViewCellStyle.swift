//
//  EdenTextMessageCollectionViewStyle.swift
//  Eden
//
//  Created by Max Alexander on 12/31/16.
//  Copyright © 2016 Epoque. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions

class RChatImageMessageCollectionViewCellStyle : TextMessageCollectionViewCellDefaultStyle {

    init(){
        let colors = BaseMessageCollectionViewCellDefaultStyle.Colors(incoming: RChatConstants.Colors.clouds, outgoing: RChatConstants.Colors.primaryColor)
        let style = BaseMessageCollectionViewCellDefaultStyle(colors: colors)
        super.init(baseStyle: style)

    }

    override func textFont(viewModel: TextMessageViewModelProtocol, isSelected: Bool) -> UIFont {
        return RChatConstants.Fonts.regularFont
    }



}
