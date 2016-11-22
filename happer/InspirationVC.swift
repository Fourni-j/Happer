//
//  InspirationVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class InspirationVC: BaseMenuViewController, UITabBarDelegate, UITableViewDataSource {

    // MARK : - attributs
    
    var categories: [Selfie.Category] = [.OOTD, .OOTN, .Bags, .Accessories, .Shoes, .Relaxed]
    var tableViewData = [Dictionary<String,String>]()
    var selectedCategory = Selfie.Category.Unknown
    var selectedTitle = ""
    
    // filters
    
    var custom = HappieView()
    var filter = UIView()
    
    @IBOutlet weak var catTable: UITableView!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var notifButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Entry point of navigation on main.storyboard
        // Envoie vers la page de login
        //Session.sharedInstance.router.perform("route://Login/mainPage#modal", sender: self)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToHappLike), name: "happLike", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToShare), name: "share", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InspirationVC.moveToFriends), name:  "friends", object: nil)

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

        let happerL = HapperLogo(frame: CGRect(x: (viewW / 2 - 25), y: (viewH - 150), width: 50, height: 50))
        happerL.button.addTarget(self, action: #selector(InspirationVC.callHappieView), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(happerL)
        addSlideMenuButton()
        tableViewData.append(["label":"Tenue de jour", "background":"OotdBack"])
        tableViewData.append(["label":"Tenue de soirée", "background":"OotnBack"])
        tableViewData.append(["label":"Sacs", "background":"BagsBack"])
        tableViewData.append(["label":"Accessoires", "background":"AccessoriesBack"])
        tableViewData.append(["label":"Chaussures", "background":"ShoesBack"])
        tableViewData.append(["label":"Décontracté", "background":"RelaxedBack"])
        
        // navbar title font and rigth button with icon
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "RemachineScriptPersonalUseOnly", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]

        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn1.setImage(UIImage(named: "dressIcon"), forState: .Normal)
        btn1.addTarget(self, action: #selector(InspirationVC.moveToDressing), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn1)

        // top left and right button (circle and notif)
        self.view.bringSubviewToFront(circleButton)

        notifButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 2, 4)
        self.view.bringSubviewToFront(notifButton)
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
    
    // MARK: - topBar methods
    
    @IBAction func menuAction(sender: AnyObject) {
        super.toggleMenu()
    }

    func moveToDressing() {
        Session.sharedInstance.router.perform("route://UserPages/dressVC#push", sender: self)
    }

    // MARK: - tableView methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.catTable.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCell
        cell.cellName.text = tableViewData[indexPath.row]["label"]
        cell.cellBackground.image = UIImage(named: tableViewData[indexPath.row]["background"]!)
        cell.contentView.sendSubviewToBack(cell.cellBackground)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedCategory = categories[indexPath.row]
        selectedTitle = tableViewData[indexPath.row]["label"]!
        performSegueWithIdentifier("goFilActu", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

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

    func moveToHappLike() {
        Session.sharedInstance.router.perform("route://Happies/happLikeVC#push", sender: self)
    }
    
    func moveToShare() {
        Session.sharedInstance.router.perform("route://Happies/uploadVC#push", sender: self)
    }
    
    func moveToFriends() {
        Session.sharedInstance.router.perform("route://Happies/askHelpVC#push", sender: self)
    }
    
    // MARK : - Fonctions happies

    func callHappieView() {
        self.filter.hidden = false
    }

    func dismissHappieView() {
        self.filter.hidden = true
    }

}
