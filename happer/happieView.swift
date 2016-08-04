//
//  happieView.swift
//  happer
//
//  Created by Josse on 04/08/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class happieView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.brownColor()
        let happLikeButton = UIButton()
        let shareButton = UIButton()
        let friendButton = UIButton()
        happLikeButton.addTarget(self, action: #selector(happieView.happLikeTap), forControlEvents: UIControlEvents.TouchUpInside)
        happLikeButton.frame = CGRectMake(6, 50, 35, 35)
        happLikeButton.backgroundColor = UIColor.blueColor()
        happLikeButton.setTitle("H", forState: UIControlState.Normal)
        shareButton.addTarget(self, action: #selector(happieView.shareTap), forControlEvents: UIControlEvents.TouchUpInside)
        shareButton.frame = CGRectMake(65, 50, 35, 35)
        shareButton.backgroundColor = UIColor.blueColor()
        shareButton.setTitle("S", forState: UIControlState.Normal)
        friendButton.addTarget(self, action: #selector(happieView.friendTap), forControlEvents: UIControlEvents.TouchUpInside)
        friendButton.frame = CGRectMake(119, 50, 35, 35)
        friendButton.backgroundColor = UIColor.blueColor()
        friendButton.setTitle("F", forState: UIControlState.Normal)
        self.addSubview(happLikeButton)
        self.addSubview(shareButton)
        self.addSubview(friendButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func happLikeTap(sender: UIButton) {
        print("happTap")
    }

    func shareTap(sender: UIButton) {
        print("shareTap")
    }

    func friendTap(sender: UIButton) {
        print("friendTap")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
