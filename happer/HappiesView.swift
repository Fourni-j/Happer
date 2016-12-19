//
//  HappiesView.swift
//  happer
//
//  Created by Charles Fournier on 07/12/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

protocol HappiesViewDelegate : class {
    func didSelectNotationAction(sender: HappiesView)
    func didSelectShareAction(sender: HappiesView)
    func didSelectFriendAction(sender: HappiesView)
}


@IBDesignable

class HappiesView: UIView {

    weak var delegate: HappiesViewDelegate?

    var contentView: UIView?
    @IBOutlet weak var frameView: UIView!
    
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
        contentView?.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        contentView?.backgroundColor = UIColor.clearColor()
        addSubview(contentView!)
        setup()
    }

    func loadViewFromNib() -> UIView! {
        let bundle = NSBundle(forClass: HappiesView.self)
        let nib = UINib(nibName: String(HappiesView.self), bundle: bundle)
        let loadedView = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return loadedView
    }
    
    private func setup() {
        frameView.layer.cornerRadius = 5
        backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func notationAction(sender: AnyObject) {
        delegate?.didSelectNotationAction(self)
    }

    @IBAction func shareAction(sender: AnyObject) {
        delegate?.didSelectShareAction(self)
    }

    @IBAction func friendAction(sender: AnyObject) {
        delegate?.didSelectFriendAction(self)
    }
}
