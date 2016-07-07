//
//  filActuCell.swift
//  happer
//
//  Created by Josse on 07/07/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class filActuCell: UITableViewCell {

    // MARK : - attributs
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellRating: UIView!
    @IBOutlet weak var cellLikeCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
