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
    @IBOutlet weak var circleTableView: UITableView!
 
    var circles = [Circle.Silver, Circle.Gold, Circle.Platine,
                   Circle.Ruby, Circle.Sapphire]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cercles"
        circleTableView.alwaysBounceVertical = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? ProductPageVC {
            destinationVC.currentCircle = selectedCircle
        }
    }
}

extension ProductCircleVC : UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("circleTableViewCell", forIndexPath: indexPath) as! CircleTableViewCell
        cell.setup(circles[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCircle = circles[indexPath.row]
        Session.sharedInstance.router.perform("route://Product/productPageVC#push", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height: CGFloat = circleTableView.frame.height / CGFloat(circles.count)
        return height
    }
    
}
