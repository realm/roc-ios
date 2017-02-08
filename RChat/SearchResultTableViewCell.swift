//
//  SearchResultTableViewCell.swift
//  RChat
//
//  Created by Max Alexander on 2/8/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography

class SearchResultTableViewCell: UITableViewCell {

    static let REUSE_ID = "SearchResultTableViewCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
