//
//  filactuVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class filactuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK : - NSUserDefault
    
    var cache = NSUserDefaults.standardUserDefaults()
    
    //MARK : - attributs
    
    @IBOutlet weak var mylabel: UILabel!
    var jsonData = NSDictionary()

    @IBOutlet weak var table: UITableView!
    var indexSelected: Int = 0
    let catTab: [String] = ["Ootd", "Ootn", "Sacs", "Accessoires", "Chaussures", "Decontracte"]
    var selfieTab: [selfieClass] = []
    
    // transmission
    
    var toTransmit = selfieClass(ownerID: 0, nbLike: 0, rate: 0, id: 0, categoryName: "default", path: "ec2-52-49-149-140.eu-west-1.compute.amazonaws.com/uploads/selfie20.jpg")

    // filters
    
    var custom: happieView = happieView()
    var filter: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(inspirationVC.moveToHappLike), name: "happLike", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(inspirationVC.moveToShare), name: "share", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(inspirationVC.moveToFriends), name: "friends", object: nil)
        
        let viewW = self.view.frame.width
        let viewH = self.view.frame.height
        
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(inspirationVC.dismissHappieView))
        
        // préparation vue happies et filtre
        
        self.custom = happieView(frame: CGRect(x: (viewW / 2 - 80), y: (viewH / 2), width: 160, height: 130))
        self.filter = UIView(frame: CGRect(x: 0, y: 0, width: viewW, height: viewH))
        self.filter.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.filter.addGestureRecognizer(tapOut)
        self.view.addSubview(filter)
        self.filter.addSubview(custom)
        self.filter.hidden = true
        
        let happerL = happerLogo(frame: CGRect(x: (viewW / 2 - 25), y: (viewH - 80), width: 50, height: 50))
        happerL.button.addTarget(self, action: #selector(filactuVC.callHappieView), forControlEvents: UIControlEvents.TouchUpInside)
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
        let cell = self.table.dequeueReusableCellWithIdentifier("filActuCell", forIndexPath: indexPath) as! filActuCell
        let selfie = selfieTab[indexPath.row]
        cell.cellRating.rating = Float(selfie.getRate())
        cell.cellImage.image = selfie.getImage()
        cell.cellLikeCount.text = String(selfie.getNbLike())
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
        let tab: NSDictionary = result.valueForKey("content") as! NSDictionary;
        var new: selfieClass
        for val in tab {
            new = selfieClass(ownerID: val.value["owner"] as! Int, nbLike: val.value["nbLike"] as! Int, rate: val.value["rate"] as! Int, id: val.value["id"] as! Int, categoryName: self.catTab[indexSelected] as String, path: val.value["url"] as! String)
            selfieTab += [new]
        }
    }

    @IBAction func backButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("inspiVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToInspi" {
            let destination = segue.destinationViewController as! detailSelfieVC
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
