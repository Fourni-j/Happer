//
//  CircleTableViewCell.swift
//  happer
//
//  Created by Charles Fournier on 28/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class CircleTableViewCell: UITableViewCell {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(circle: Circle) {
        circleView.transform = CGAffineTransformMakeRotation(CGFloat(45.degreesToRadians))
        circleView.backgroundColor = UIColor.colorFromCircle(circle)
        circleNameLabel.text = circle.value
        
        switch circle {
        case .Silver:
            descriptionLabel.text = "Les produits compris entre 0 et 100€"
        case .Gold:
            descriptionLabel.text = "Les produits compris entre 100 et 300€"
        case .Platine:
            descriptionLabel.text = "Les produits compris entre 300 et 500€"
        case .Ruby:
            descriptionLabel.text = "Les produits compris entre 500 et 1000€"
        case .Sapphire:
            descriptionLabel.text = "Les produits compris entre 1000€ ou plus"
        default:
            descriptionLabel.text = ""
        }
        
        lockImageView.hidden = true
        
        
    }
}
