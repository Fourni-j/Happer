//
//  NewsFeedVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

class NewsFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK : - NSUserDefault
    
    var cache = NSUserDefaults.standardUserDefaults()
    
    //MARK : - attributs
    
    @IBOutlet weak var mylabel: UILabel!
    var jsonData = NSDictionary()
    
    @IBOutlet weak var table: UITableView!
    var indexSelected = 0
    let catTab = ["Ootd", "Ootn", "Sacs", "Accessoires", "Chaussures", "Decontracte"]
    var selfieTab: [Selfie] = []
    
    // transmission
    
    var toTransmit = Selfie()
    
    // filters
    
    var custom = HappieView()
    var filter = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToHappLike), name: "happLike", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToShare), name: "share", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToFriends), name: "friends", object: nil)
        
        let viewW = self.view.frame.width
        let viewH = self.view.frame.height
        
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(InspirationVC.dismissHappieView))
        
        // préparation vue happies et filtre
        
        self.custom = HappieView(frame: CGRect(x: (viewW / 2 - 80), y: (viewH / 2), width: 160, height: 130))
        self.filter = UIView(frame: CGRect(x: 0, y: 0, width: viewW, height: viewH))
        self.filter.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.filter.addGestureRecognizer(tapOut)
        self.view.addSubview(filter)
        self.filter.addSubview(custom)
        self.filter.hidden = true
        
        let happerL = HapperLogo(frame: CGRect(x: (viewW / 2 - 25), y: (viewH - 80), width: 50, height: 50))
        happerL.button.addTarget(self, action: #selector(NewsFeedVC.callHappieView), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(happerL)
        
        
        self.mylabel.text = catTab[indexSelected]
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/get\(catTab[indexSelected]).php")
        getSelfies(url!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tableView methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selfieTab.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCellWithIdentifier("newsFeedCell", forIndexPath: indexPath) as! NewsFeedCell
        let selfie = selfieTab[indexPath.row]
        cell.cellRating.rating = Float(selfie.rating)
        cell.cellImage.af_setImageWithURL(selfie.imageURL)
        cell.cellLikeCount.text = "\(selfie.nbLike)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.toTransmit = selfieTab[indexPath.row]
        performSegueWithIdentifier("goToInspi", sender: self)
    }
    
    func getSelfies(url: NSURL) {
        let jsonData = NSData(contentsOfURL: url)
        var result = NSDictionary()
        do {
            result = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        }
        catch {
            print("Error catched, func getSelfie() in filactuVC.swift")
            return
        }
        let tab = result.valueForKey("content") as! NSDictionary
        var new: Selfie
        for val in tab {
            new = Selfie()
            new.id = val.value["id"] as! Int
            new.category = Selfie.Category.init(value: self.catTab[indexSelected] as String)
            new.state = Selfie.State.init(value: -1)
            new.nbLike = val.value["nbLike"] as! Int
            new.rating = val.value["rate"] as! Int
            new.imageURLString = val.value["url"] as! String
            selfieTab += [new]
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToInspi" {
            let destination = segue.destinationViewController as! SelfieDetailsVC
            destination.selfie = self.toTransmit
            destination.indexSelected = self.indexSelected
        }
    }
    
    func moveToHappLike() {
        cache.setObject("actuVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Happies", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("happLikeVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func moveToShare() {
        cache.setObject("actuVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Happies", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("uploadVC")
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func moveToFriends() {
        cache.setObject("actuVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Happies", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("askHelpVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK : - Fonctions happies
    
    func callHappieView() {
        self.filter.hidden = false
    }
    
    func dismissHappieView() {
        self.filter.hidden = true
    }
    
}
