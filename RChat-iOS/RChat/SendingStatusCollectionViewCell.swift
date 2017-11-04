//
//  SendingStatusCollectionViewCell.swift
//  Eden
//
//  Created by Max Alexander on 12/31/16.
//  Copyright © 2016 Epoque. All rights reserved.
//

import UIKit

class SendingStatusCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var label: UILabel!

    var text: NSAttributedString? {
        didSet {
            self.label.attributedText = self.text
        }
    }
}
