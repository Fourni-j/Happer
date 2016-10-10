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
    
}
