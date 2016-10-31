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
    
    //MARK : - attributs
    
    var jsonData = NSDictionary()
    
    @IBOutlet weak var table: UITableView!
    var indexSelected = 0
    let catTab = ["Ootd", "Ootn", "Sacs", "Accessoires", "Chaussures", "Decontracte"]
    var selfieTab: [Selfie] = []
    
    // transmission
    
    var toTransmit = Selfie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToHappLike), name: "happLike", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToShare), name: "share", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToFriends), name: "friends", object: nil)
        
        title = catTab[indexSelected]
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/get\(catTab[indexSelected]).php")
        getSelfies(url!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.cellImage.userInteractionEnabled = false
        cell.cellImage.clipsToBounds = true
        cell.cellImage.contentMode = .ScaleAspectFill
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as!  NewsFeedCell
        cell.cellImage.tagHidden = !cell.cellImage.tagHidden
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
            new.nbLike = val.value["nbLike"] as! Int
            new.state = Selfie.State.Unknown
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
}
