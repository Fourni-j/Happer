//
//  ProductSmallCollectionViewCell.swift
//  happer
//
//  Created by Charles Fournier on 15/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ProductSmallCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bidView: BidView!
    @IBOutlet var imageViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet var imageViewWonCenterConstraint: NSLayoutConstraint!
    
    var overlayView: UIView?
    var overlayPrice: UILabel?
    
    private var _cellState = Product.State.Unknown
    var cellState : Product.State {
        get { return _cellState }
        set(newCellState) {
            _cellState = newCellState
            switch cellState {
            case .Available, .Unknown:
                availableLayout()
            case .Soon:
                soonLayout()
            case .Won:
                wonLayout()
            }
        }
    }
    
    func setup(product: Product) {
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        titleLabel.text = product.brand
        priceLabel.text = "\(Int(product.price))€"
        layoutIfNeeded()
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFit
        imageView.af_setImageWithURL(product.imageURL)
        bidView.setup(true)
        bidView.updateFillWith(completedTime: CGFloat(240), totalTime: CGFloat(480))

        overlayView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        overlayView?.backgroundColor = UIColor.darkGrayColor()
        overlayView?.alpha = 0.7
        overlayView?.hidden = true
  
        overlayPrice = UILabel(frame: priceLabel.frame)
        overlayPrice?.text = "Prix réel \(Int(product.price))€"
        overlayPrice?.textColor = UIColor.whiteColor()

        
        overlayView?.addSubview(overlayPrice!)
        
        cellState = product.state
        addSubview(overlayView!)
    }
    
    func availableLayout() {
        overlayView?.hidden = true
        priceLabel.hidden = false
        imageViewWonCenterConstraint.active = false
        imageViewCenterConstraint.active = true
    }
    
    func soonLayout() {
        overlayView?.hidden = false
        priceLabel.hidden = true
        imageViewWonCenterConstraint.active = false
        imageViewCenterConstraint.active = true
    }
    
    func wonLayout() {
        overlayView?.hidden = true
        priceLabel.hidden = false
        bidView.hidden = true
        imageViewCenterConstraint.active = false
        imageViewWonCenterConstraint.active = true
    }
}
