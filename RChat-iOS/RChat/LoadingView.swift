//
//  LoadingView.swift
//  EChat
//
//  Created by Max Alexander on 1/21/17.
//  Copyright © 2017 Max Alexander. All rights reserved.
//

import UIKit
import Cartography
import NVActivityIndicatorView

class LoadingView : UIView {

    lazy var backgroundView : UIView = {
        let v = UIView()
        v.alpha = 0.5
        v.backgroundColor = UIColor.black
        return v
    }()

    lazy var activityIndicatorView : NVActivityIndicatorView = {
        let v = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .orbit, color: UIColor.white)
        return v
    }()

    init(){
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit(){
        addSubview(backgroundView)
        addSubview(activityIndicatorView)

        constrain(backgroundView, activityIndicatorView) { (backgroundView, activityIndicatorView) in
            backgroundView.left == backgroundView.superview!.left
            backgroundView.bottom == backgroundView.superview!.bottom
            backgroundView.top == backgroundView.superview!.top
            backgroundView.right == backgroundView.superview!.right

            activityIndicatorView.width == 80
            activityIndicatorView.height == 80
            activityIndicatorView.centerX == activityIndicatorView.superview!.centerX
            activityIndicatorView.centerY == activityIndicatorView.superview!.centerY

        }
    }

    static func show(superView: UIView){
        superView.endEditing(false)
        hide(superView: superView)
        let loadingView = LoadingView()
        superView.addSubview(loadingView)
        constrain(loadingView) { (v) in
            v.left == v.superview!.left
            v.right == v.superview!.right
            v.top == v.superview!.top
            v.bottom == v.superview!.bottom
        }
        loadingView.activityIndicatorView.startAnimating()
    }

    static func hide(superView: UIView){
        for subview in superView.subviews {
            if subview is LoadingView {
                UIView.animate(withDuration: 0.25, animations: {
                    subview.removeFromSuperview()
                })

            }
            for subview1 in subview.subviews {
                if subview1 is LoadingView {
                    UIView.animate(withDuration: 0.25, animations: {
                        subview1.removeFromSuperview()
                    })
                }
            }
        }
    }
    
}
