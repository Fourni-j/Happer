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
    @IBOutlet weak var bidView: BidView!
    
    var overlayView: UIView?
    var overlayPrice: UILabel?
    
    private var _cellState = Product.State.Unknown
    var cellState : Product.State {
        get { return _cellState }
        set(newCelleState) {
            _cellState = newCelleState
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
        layoutIfNeeded()
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        brandLabel.text = product.brand
        descriptionLabel.text = product.desc
        priceLabel.text = "\(Int(product.price))€"
        imageView.af_setImageWithURL(product.imageURL)
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFit
        cellState = product.state
        bidView.setup(true)
        bidView.updateFillWith(completedTime: CGFloat(240), totalTime: CGFloat(480))
        
        overlayView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        overlayView?.backgroundColor = UIColor.darkGrayColor()
        overlayView?.alpha = 0.7
        overlayView?.hidden = true
        
        overlayPrice = UILabel(frame: priceLabel.frame)
        overlayPrice?.text = "Prix réel \(Int(product.price))€"
        overlayPrice?.textColor = UIColor.whiteColor()

        
    }
    
    func availableLayout() {
        overlayView?.hidden = true
        priceLabel.hidden = false
    }
    
    func soonLayout() {
        overlayView?.hidden = false
        priceLabel.hidden = true
    }
    
    func wonLayout() {
        overlayView?.hidden = true
        priceLabel.hidden = false
        bidView.hidden = true
    }
    
    
    
}
