//
//  TimeSeperatorCollectionViewCell.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import Foundation
import UIKit
import Chatto

class TimeSeparatorCollectionViewCell: UICollectionViewCell {

    private let label: UILabel = {
        let label = ColorLabel()
        label.backgroundColor = UIColor(white: 0.2, alpha: 0.25)
        label.cornerRadius = 8
        label.hPadding = 10
        label.vPadding = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.clear
        self.contentView.addSubview(label)
    }

    var text: String = "" {
        didSet {
            if oldValue != text {
                self.setTextOnLabel(text)
            }
        }
    }

    private func setTextOnLabel(_ text: String) {
        self.label.text = text
        self.setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.bounds.size = self.label.sizeThatFits(self.contentView.bounds.size)
        self.label.center = self.contentView.center
    }
}
