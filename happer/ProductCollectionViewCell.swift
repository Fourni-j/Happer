//
//  ProductCollectionViewCell.swift
//  happer
//
//  Created by Charles Fournier on 04/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var overlayLabel: UILabel!
    @IBOutlet weak var bidView: BidView!
    
    private var _cellState = Product.State.Unknown
    var cellState : Product.State {
        get { return _cellState }
        set(newCelleState) {
            _cellState = newCelleState
            switch cellState {
            case .Available, .Unknown:
                overlayView.hidden = true
            case .Soon, .Won:
                overlayView.hidden = false
                overlayLabel.text = cellState.rawValue
            }
        }
    }
    
    func setup(product: Product) {
        layoutIfNeeded()
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        brandLabel.text = product.brand
        descriptionLabel.text = product.desc
        priceLabel.text = "\(product.price)"
        imageView.af_setImageWithURL(product.imageURL)
        cellState = product.state
        bidView.setup(true)
        //        bidView.updateFillWith(completedTime: CGFloat(product.completedTime), totalTime: CGFloat(product.totalTime))
    }
    
}
