//
//  InspirationVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class InspirationVC: BaseMenuViewController, UITabBarDelegate {
    
    var categories: [Selfie.Category] = [.OOTD, .OOTN, .Bags, .Accessories, .Shoes, .Relaxed]
    var tableViewData = [Dictionary<String,String>]()
    var selectedCategory = Selfie.Category.Unknown
    var selectedTitle = ""
    
    var customCategory = [[String:AnyObject]]()
    
    @IBOutlet weak var catTable: UITableView!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var notifButton: UIButton!
    @IBOutlet weak var happiesButton: UIButton!
    @IBOutlet weak var happiesView: HappiesView!
    @IBOutlet weak var happiesOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(happiesAction))
        self.happiesOverlay.addGestureRecognizer(tapOut)
        
        addSlideMenuButton()
        tableViewData.append(["label":"Tenue de jour", "background":"OotdBack"])
        tableViewData.append(["label":"Tenue de soirée", "background":"OotnBack"])
        tableViewData.append(["label":"Sacs", "background":"BagsBack"])
        tableViewData.append(["label":"Accessoires", "background":"AccessoriesBack"])
        tableViewData.append(["label":"Chaussures", "background":"ShoesBack"])
        tableViewData.append(["label":"Décontracté", "background":"RelaxedBack"])
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "RemachineScriptPersonalUseOnly", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn1.setImage(UIImage(named: "dressIcon"), forState: .Normal)
        btn1.addTarget(self, action: #selector(InspirationVC.moveToDressing), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn1)
        notifButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 2, 4)
        happiesView.delegate = self
        
        happiesView.hidden = true
        happiesOverlay.hidden = true
        
        updateCategory()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "Inspiration du jour"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateCategory() {
        Api.getCategories()
            .then { data in
                
                let type = data as! [String: AnyObject]
                let array = type["categories"] as! [[String: AnyObject]]
                for categoriesJSON in array {
                    let dict = ["name":categoriesJSON["name"]!,
                    "picture_url":categoriesJSON["picture_url"]!]
                    self.customCategory.append(dict)
                }
                self.catTable.reloadData()
        }
    }
    
    @IBAction func menuAction(sender: AnyObject) {
        super.toggleMenu()
    }
    
    func moveToDressing() {
        Session.sharedInstance.router.perform("route://UserPages/dressVC#push", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goFilActu" {
            let destination = segue.destinationViewController as! NewsFeedVC
            destination.currentCategory = selectedCategory
            destination.currentTitle = selectedTitle
        }
    }
    
    @IBAction func circleAction(sender: UIButton) {
        Session.sharedInstance.router.perform("route://Product/productCircleVC#push", sender: self)
    }
    
    @IBAction func notifAction(sender: UIButton) {
        print("====> NOTIF BUTTON PRESSED <====")
    }
    
    @IBAction func happiesAction(sender: AnyObject) {
        self.happiesView.hidden = !self.happiesView.hidden
        self.happiesOverlay.hidden = !self.happiesOverlay.hidden
    }
}

extension InspirationVC : HappiesViewDelegate {

    func didSelectShareAction(sender: HappiesView) {
        Session.sharedInstance.router.perform("route://Happies/uploadVC#push", sender: self)
    }
    
    func didSelectFriendAction(sender: HappiesView) {
        Session.sharedInstance.router.perform("route://Happies/askHelpVC#push", sender: self)
    }
    
    func didSelectNotationAction(sender: HappiesView) {
        Session.sharedInstance.router.perform("route://Happies/happLikeVC#push", sender: self)
    }
    
}

extension InspirationVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customCategory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.catTable.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCell
        let imageUrlString = customCategory[indexPath.row]["picture_url"] as! String
        let imageUrl = NSURL(string: "http:" + imageUrlString)!
        cell.backgroundColor = UIColor.lightGrayColor()
        cell.cellBackground.af_setImageWithURL(imageUrl)
        cell.cellName.text = customCategory[indexPath.row]["name"] as? String
        cell.cellBackground.contentMode = .ScaleAspectFill
        cell.contentView.sendSubviewToBack(cell.cellBackground)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let categoryName = customCategory[indexPath.row]["name"] as! String
        selectedCategory = Selfie.Category.init(value: categoryName)
        selectedTitle = customCategory[indexPath.row]["name"] as! String
        performSegueWithIdentifier("goFilActu", sender: self)
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160.0
    }
}
