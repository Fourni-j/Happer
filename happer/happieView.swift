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
        
        self.layer.cornerRadius = 5
        
        self.backgroundColor = UIColor.blackColor()
        let happLikeButton = UIButton()
        let shareButton = UIButton()
        let friendButton = UIButton()

        happLikeButton.addTarget(self, action: #selector(happieView.happLikeTap), forControlEvents: UIControlEvents.TouchUpInside)
        happLikeButton.frame = CGRectMake((frame.width / 2 - 75), 70, 40, 40)
        happLikeButton.setImage(UIImage(named: "Mock_up_final_Happ'like"), forState: UIControlState.Normal)
        shareButton.addTarget(self, action: #selector(happieView.shareTap), forControlEvents: UIControlEvents.TouchUpInside)
        shareButton.frame = CGRectMake((frame.width / 2 - 20), 70, 40, 40)
        shareButton.setImage(UIImage(named: "Mock_up_final_Partager"), forState: UIControlState.Normal)
        friendButton.addTarget(self, action: #selector(happieView.friendTap), forControlEvents: UIControlEvents.TouchUpInside)
        friendButton.frame = CGRectMake((frame.width / 2 + 35), 70, 40, 40)
        friendButton.setImage(UIImage(named: "Mock_up_final_Amis"), forState: UIControlState.Normal)
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
