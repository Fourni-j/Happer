//
//  HapperLogo.swift
//  happer
//
//  Created by Josse on 04/08/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class HapperLogo: UIView {

    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.button.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.button.setImage(UIImage(named: "Logo_transparent_100x100"), forState: UIControlState.Normal)
        self.addSubview(self.button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
