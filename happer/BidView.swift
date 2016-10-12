
//  BidView.swift
//  happer
//
//  Created by Charles Fournier on 12/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

protocol BidViewDelegate : class {
    func didTapBid()
}

@IBDesignable
class BidView: UIView {
    
    var fillView = UIView()
    var actionButton: UIButton!
    var isBuild = false
    
    weak var delegate: BidViewDelegate?
    
    private func build() {
        backgroundColor = UIColor.blackColor()
        layer.cornerRadius = frame.height / 2.5
        actionButton = UIButton(type: .System)

        addSubview(fillView)
        addSubview(actionButton)
        
        actionButton.backgroundColor = UIColor.clearColor()
        fillView.backgroundColor = UIColor(red:0.76, green:0.20, blue:0.23, alpha:1.00)
        
        fillView.frame = CGRect(x: 0, y: 0, width: 0, height: frame.height)
        fillView.layer.cornerRadius = fillView.frame.height / 2.5

        actionButton.setTitle("Happer", forState: .Normal)
        actionButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        actionButton.titleLabel?.textAlignment = .Center
        actionButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        actionButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        isBuild = true
    }
    
    func setup(displayOnly: Bool) {
        if !isBuild {
            build()
        }
        
        if displayOnly {
            userInteractionEnabled = false
        } else {
            userInteractionEnabled = true
        }
    }
    
    func updateFillWith(completedTime completedTIme: CGFloat, totalTime: CGFloat) {
        let fillMultiplier = completedTIme / totalTime
        let fillValue = frame.width * fillMultiplier
        fillView.frame = CGRect(x: 0, y: 0, width: fillValue, height: frame.height)
    }
    
    func buttonAction(sender: UIButton!) {
        delegate?.didTapBid()
    }
}
