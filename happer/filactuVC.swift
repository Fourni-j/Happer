//
//  filactuVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class filactuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK : - attributs
    @IBOutlet weak var mylabel: UILabel!
    var jsonData = NSDictionary()
    var viewID = "actuVC"
    var prevID = ""

    @IBOutlet weak var table: UITableView!
    var indexSelected: Int = 0
    let catTab: [String] = ["Ootd", "Ootn", "Sacs", "Accessoires", "Chaussures", "Decontracte"]
    var selfieTab: [selfieClass] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.mylabel.text = catTab[indexSelected]
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/get\(catTab[indexSelected]).php")
        getSelfies(url!)
        //print(selfieTab)
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
        let vc = story.instantiateViewControllerWithIdentifier(prevID)
        self.presentViewController(vc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
