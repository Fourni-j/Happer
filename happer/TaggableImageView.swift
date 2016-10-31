//
//  TaggableImageView.swift
//  happer
//
//  Created by Charles Fournier on 27/09/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TaggableImageView : UIImageView {
    
    private var editingTextField: Bool = false
    private var filledArea: [Int: [String: CGPoint]] = [:]
    private var textFields: [UITextField] = []
    private var indicators: [UIImageView] = []
    private var activeTextField: UITextField!
    private var _tagHidden: Bool = false
    
    var tagHidden : Bool {
        get {
           return _tagHidden
        }
        set {
            _tagHidden = newValue
            for textField in textFields {
                textField.hidden = _tagHidden
            }
            for indicator in indicators {
                indicator.hidden = _tagHidden
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        initialize()
    }
    
    func initialize() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.numberOfTapsRequired = 1;
        self.addGestureRecognizer(tapGestureRecognizer)
        self.userInteractionEnabled = true
        self.contentMode = .ScaleAspectFit
    }
    
    func tap(touch: UITapGestureRecognizer) {
        let touchPoint = touch.locationInView(self)
        add("", atPoint: touchPoint)
    }
    
    private func checkIfAreaIsEmpty(touchPoint: CGPoint) -> Bool {
        let nSP: CGPoint = CGPoint(x: touchPoint.x - 8, y: touchPoint.y)
        let nEP: CGPoint = CGPoint(x: touchPoint.x + 92, y: touchPoint.y + 34.5)
        let nW: CGFloat = nEP.x - nSP.x
        let nH: CGFloat = nEP.y - nSP.y
        var i: Int = 0
        while let area:[String: CGPoint] = filledArea[i] {
            let sP: CGPoint = area["startPoint"]!
            let eP: CGPoint = area["endPoint"]!
            let w: CGFloat = eP.x - sP.x
            let h: CGFloat = eP.y - sP.y
            if nSP.x - sP.x < nW && sP.x - nSP.x < w && nSP.y - sP.y < nH && sP.y - nSP.y < h {
                return false
            } else {
                i += 1
            }
        }
        let area = ["startPoint": nSP, "endPoint": nEP]
        filledArea[i] = area
        return true
    }
    
    private func creatTextField(text: String, atPoint touchPoint: CGPoint) {
        let indicatorView = UIImageView(frame: CGRectMake(touchPoint.x - 8, touchPoint.y, 16, 13.5))
        indicatorView.image = UIImage(named: "triangle")
        self.addSubview(indicatorView)
        let textField = UITextField(frame: CGRectMake(touchPoint.x - 8, touchPoint.y +  13.5, 100, 21))
        //textField.font = UIFont(name: "Helvetica", size: 12.0)
        textField.placeholder = "Marque"
        textField.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8).CGColor
        let textFieldImageView = UIView(frame: CGRectMake(0, 0, 9, 21))
        textFieldImageView.backgroundColor = UIColor.clearColor()
        let textFieldImage = UIView(frame: CGRectMake(3, 3, 3, 15))
        textFieldImage.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        textFieldImageView.addSubview(textFieldImage)
        textField.leftView = textFieldImageView
        textField.leftViewMode = UITextFieldViewMode.Always
        textField.returnKeyType = .Done
        textField.text = text
        textFields += [textField]
        indicators += [indicatorView]
        self.addSubview(textField)
        textField.delegate = self
        activeTextField = textField
    }
    
    override func endEditing(force: Bool) -> Bool {
        activeTextField.resignFirstResponder()
        return true
    }
    
    func add(text: String, atPoint point: CGPoint) {
        if editingTextField == false {
            print("touchPoint is \(point)...")
            if point.y + 34.5 < self.frame.height &&
                point.x + 92 < self.frame.width &&
                point.x - 8 > 0 &&
                checkIfAreaIsEmpty(point) {
                creatTextField(text, atPoint: point)
                activeTextField.becomeFirstResponder()
            } else {
                print(" ... but we cant creat textField here")
                return
            }
        } else {
            endEditing(true)
            editingTextField = false
            self.becomeFirstResponder()
        }
    }
}

extension TaggableImageView : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        editingTextField = true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        editingTextField = false
    }
    
}
