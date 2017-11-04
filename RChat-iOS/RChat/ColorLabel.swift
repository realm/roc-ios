//
//  ColorLabel.swift
//  RChat
//
//  Created by Max Alexander on 1/10/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit

class ColorLabel: UILabel {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var hPadding: CGFloat = 0

    @IBInspectable
    var vPadding: CGFloat = 0

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textInsets = UIEdgeInsets(top: vPadding, left: hPadding, bottom: vPadding, right: hPadding)
        var rect = textInsets.apply(rect: bounds)
        rect = super.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        return textInsets.inverse.apply(rect: rect)
    }

    override func drawText(in rect: CGRect) {
        let textInsets = UIEdgeInsets(top: vPadding, left: hPadding, bottom: vPadding, right: hPadding)
        super.drawText(in: textInsets.apply(rect: rect))
    }
}
private extension UIEdgeInsets {
    var inverse: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }

    func apply(rect: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(rect, self)
    }
}
