//
//  HapplikeVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class HapplikeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var expView: UIView!
    @IBOutlet weak var notificationButton: UIButton!
    
    var fillView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.af_setImageWithURL(NSURL(string: "http://s3.eu-central-1.amazonaws.com/happer/selfies/pictures/000/000/013/original/IMG_8229.JPG?1479134155")!)
        fillExp(3, neededExp: 4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func fillExp(currentExp: Int, neededExp: Int) {
        
        let percentage: CGFloat = CGFloat(currentExp) / CGFloat(neededExp)
        
        if fillView == nil {
            fillView = UIView(frame: CGRectMake(0, 0, expView.frame.width * percentage, expView.frame.height))
            fillView?.backgroundColor = UIColor(red:0.96, green:0.83, blue:0.21, alpha:1.00)
            expView.addSubview(fillView!)
        } else {
            fillView?.frame = CGRectMake(0, 0, expView.frame.width * percentage, expView.frame.height)
        }
    }
    
    @IBAction func notificationAction(sender: AnyObject) {
    }
    
}
