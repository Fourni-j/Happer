//
//  TopView.swift
//  happer
//
//  Created by Charles Fournier on 16/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

@IBDesignable

class TopView: UIView {
    
    @IBOutlet weak var sapphireView: UIView!
    @IBOutlet weak var goldView: UIView!
    @IBOutlet weak var rubyView: UIView!
    @IBOutlet weak var silverView: UIView!
    @IBOutlet weak var platineView: UIView!
    
    @IBOutlet weak var sapphireImageView: UIImageView!
    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var rubyImageView: UIImageView!
    @IBOutlet weak var silverImageView: UIImageView!
    @IBOutlet weak var platineImageView: UIImageView!
    
    @IBOutlet weak var happiesLabel: UILabel!
   
    @IBOutlet weak var expView: UIView!
    
    @IBOutlet var view: UIView!
   
    var contentView: UIView?
    var fillView: UIView?
    var selected: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        contentView!.frame = bounds
        contentView!.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(contentView!)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = NSBundle(forClass: TopView.self)
        let nib = UINib(nibName: String(TopView.self), bundle: bundle)
        let loadedView = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return loadedView
    }
    
    private func setup() {
        silverView.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.00)
        goldView.backgroundColor = UIColor(red:0.96, green:0.83, blue:0.21, alpha:1.00)
        platineView.backgroundColor = UIColor(red:0.56, green:0.57, blue:0.57, alpha:1.00)
        rubyView.backgroundColor = UIColor(red:0.73, green:0.10, blue:0.16, alpha:1.00)
        sapphireView.backgroundColor = UIColor(red:0.14, green:0.45, blue:0.72, alpha:1.00)
        
        silverView.transform = CGAffineTransformMakeRotation(CGFloat(45.degreesToRadians))
        goldView.transform = CGAffineTransformMakeRotation(CGFloat(45.degreesToRadians))
        platineView.transform = CGAffineTransformMakeRotation(CGFloat(45.degreesToRadians))
        rubyView.transform = CGAffineTransformMakeRotation(CGFloat(45.degreesToRadians))
        sapphireView.transform = CGAffineTransformMakeRotation(CGFloat(45.degreesToRadians))
        
        let lockImage = UIImage(named: "lock")
        
        silverImageView.image = lockImage
        goldImageView.image = lockImage
        platineImageView.image = lockImage
        rubyImageView.image = lockImage
        sapphireImageView.image = lockImage
        
        silverImageView.hidden = true
        goldImageView.hidden = true
        platineImageView.hidden = true
        rubyImageView.hidden = true
        sapphireImageView.hidden = true
    }
    
    func setup(user: User?) {
        setup()
        
        if user == nil { return }
        
        switch user!.circle {
        case .Silver:
            goldView.backgroundColor = UIColor.blackColor()
            platineView.backgroundColor = UIColor.blackColor()
            rubyView.backgroundColor = UIColor.blackColor()
            sapphireView.backgroundColor = UIColor.blackColor()
            goldImageView.hidden = false
            platineImageView.hidden = false
            rubyImageView.hidden = false
            sapphireImageView.hidden = false
        case .Gold:
            platineView.backgroundColor = UIColor.blackColor()
            rubyView.backgroundColor = UIColor.blackColor()
            sapphireView.backgroundColor = UIColor.blackColor()
            platineImageView.hidden = false
            rubyImageView.hidden = false
            sapphireImageView.hidden = false
        case .Platine:
            rubyView.backgroundColor = UIColor.blackColor()
            sapphireView.backgroundColor = UIColor.blackColor()
            rubyImageView.hidden = false
            sapphireImageView.hidden = false
        case .Ruby:
            sapphireView.backgroundColor = UIColor.blackColor()
            sapphireImageView.hidden = false
        default:
            print("unknown")
        }
    }
    
    func select(circle: Circle) {
        
        if (selected != nil) {
            selected?.layer.borderWidth = 0.0
        }
        
        switch circle {
        case .Silver:
            selected = silverView
        case .Gold:
            selected = goldView
        case .Platine:
            selected = platineView
        case .Ruby:
            selected = rubyView
        case .Sapphire:
            selected = sapphireView
        default:
            return
        }
        
        if selected == nil {
            return
        }
        selected?.layer.borderWidth = 2.0
        selected?.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func fillExp(currentExp: Int, neededExp: Int) {

        let percentage: CGFloat = CGFloat(currentExp) / CGFloat(neededExp)
        
        if fillView == nil {
            fillView = UIView(frame: CGRectMake(0, 0, expView.frame.width * percentage, expView.frame.height))
            fillView?.backgroundColor = UIColor.yellowColor()
            expView.addSubview(fillView!)
        } else {
            fillView?.frame = CGRectMake(0, 0, expView.frame.width * percentage, expView.frame.height)
        }
        
    }
    
    
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * M_PI / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / M_PI }
    
}
