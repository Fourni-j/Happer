//
//  NewsFeedCell.swift
//  happer
//
//  Created by Josse on 07/07/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {

    // MARK : - attributs
    
    @IBOutlet weak var cellImage: TaggableImageView!
    @IBOutlet weak var cellLikeCount: UILabel!
    @IBOutlet weak var cellRating: FloatRatingView!
    var like = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func likeButton(sender: UIButton) {
        self.like = !self.like
        if self.like == true {
            sender.setImage(UIImage(named: "likeIconFull"), forState: .Normal)
            self.cellLikeCount.textColor = UIColor.whiteColor()
        } else {
            sender.setImage(UIImage(named: "likeIconEmpty"), forState: .Normal)
            self.cellLikeCount.textColor = UIColor.blackColor()
        }
    }
}
