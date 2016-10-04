//
//  ProductCircleVC.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ProductCircleVC :  UIViewController {
    
    var selectedCircle = Circle.Unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if let destinationVC = segue.destinationViewController as? ProductVC {
            destinationVC.currentCircle = selectedCircle
        }
        
    }
    
    
    
    @IBAction func silverButtonAction(sender: AnyObject) {
        selectedCircle = Circle.Silver
        Session.sharedInstance.router.perform("route://Product/productVC#push", sender: self)
    }
    
    @IBAction func goldButtonAction(sender: AnyObject) {
        selectedCircle = Circle.Gold
        Session.sharedInstance.router.perform("route://Product/productVC#push", sender: self)
    }
    
    @IBAction func platineButtonAction(sender: AnyObject) {
        selectedCircle = Circle.Platine
        Session.sharedInstance.router.perform("route://Product/productVC#push", sender: self)
    }
    
    @IBAction func rubyButtonAction(sender: AnyObject) {
        selectedCircle = Circle.Ruby
        Session.sharedInstance.router.perform("route://Product/productVC#push", sender: self)
    }
    
    @IBAction func sapphireButtonAction(sender: AnyObject) {
        selectedCircle = Circle.Sapphire
        Session.sharedInstance.router.perform("route://Product/productVC#push", sender: self)
    }
    
}
