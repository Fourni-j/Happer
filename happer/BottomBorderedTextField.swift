//
//  BottomBorderedTextField.swift
//  happer
//
//  Created by paul on 11/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

@IBDesignable
class BottomBorderedTextField: UITextField {
    override func drawRect(rect: CGRect) {
        let startingPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomPath = UIBezierPath()
        bottomPath.moveToPoint(startingPoint)
        bottomPath.addLineToPoint(endingPoint)
        bottomPath.lineWidth = 3.0
        tintColor.setStroke()
        bottomPath.stroke()
    }
}
