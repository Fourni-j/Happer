//
//  AskFriendCollectionViewCell.swift
//  happer
//
//  Created by Charles Fournier on 20/12/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class AskFriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedOverlayView: UIView!
 
    private var _cellSelected = false
    var cellSelected : Bool {
        set {
            _cellSelected = newValue
            selectionChanged()
        }
        
        get {
            return _cellSelected
        }
    }
    
    
    private func selectionChanged() {
        selectedOverlayView.hidden = !cellSelected
    }
    
    func setup(user: FacebookUsers) {
        cellSelected = user.isSelected
        
    }
}
