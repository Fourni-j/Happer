//
//  Color.swift
//  happer
//
//  Created by Charles Fournier on 28/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func colorFromCircle(circle: Circle) -> UIColor {
        switch circle {
        case .Silver:
            return UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.00)
        case .Gold:
            return UIColor(red:0.96, green:0.83, blue:0.21, alpha:1.00)
        case .Platine:
            return UIColor(red:0.56, green:0.57, blue:0.57, alpha:1.00)
        case .Ruby:
            return UIColor(red:0.73, green:0.10, blue:0.16, alpha:1.00)
        case .Sapphire:
            return UIColor(red:0.14, green:0.45, blue:0.72, alpha:1.00)
        default:
            return UIColor.blackColor()
        }
    }
    
    
}

