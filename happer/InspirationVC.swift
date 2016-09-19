//
//  InspirationVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class InspirationVC: MenuVC, UITabBarDelegate, UITableViewDataSource {

    // MARK : - NSUSER
    
    var cache = NSUserDefaults.standardUserDefaults()
    
    // MARK : - attributs
    
    var categories: [InspiClass] = []
    var indexSelected = 0

    // filters
    
    var custom = HappieView()
    var filter = UIView()
    
    @IBOutlet weak var catTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.creatMenuView()
        cache.setObject("inspiVC", forKey: "currentVC")
        initCat()

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

        let happerL = HapperLogo(frame: CGRect(x: (viewW / 2 - 25), y: (viewH - 80), width: 50, height: 50))
        happerL.button.addTarget(self, action: #selector(InspirationVC.callHappieView), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(happerL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - self.methods
    
    func initCat() {
        let ootd = InspiClass(name: "Tenue de Jour", keyWord: "ootd")
        let ootn = InspiClass(name: "Tenue de Nuit", keyWord: "ootn")
        let sacs = InspiClass(name: "Sacs", keyWord: "sacs")
        let accessoires = InspiClass(name: "Accessoires", keyWord: "accessoires")
        let chaussures = InspiClass(name: "Chaussures", keyWord: "chaussures")
        let decontracte = InspiClass(name: "Decontracté", keyWord: "decontracte")
        categories += [ootd]
        categories += [ootn]
        categories += [sacs]
        categories += [accessoires]
        categories += [chaussures]
        categories += [decontracte]
    }
    
    // MARK: - topBar methods
    
    @IBAction func circlesButton(sender: UIButton) {
        performSegueWithIdentifier("goCercles", sender: self)
    }
    
    @IBAction func notifButton(sender: UIButton) {
        // Afficher historique notifications
    }
        
    @IBAction func menuAction(sender: AnyObject) {
        super.toggleMenu()
    }

    // MARK: - tableView methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.catTable.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCell
        cell.cellName.text = categories[indexPath.row].getName()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.indexSelected = indexPath.row
        performSegueWithIdentifier("goFilActu", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "goFilActu" {
            let destination = segue.destinationViewController as! NewsFeedVC
            destination.indexSelected = indexSelected
            cache.setObject("inspiVC", forKey: "prevVC")
        }
    }

    func moveToHappLike() {
        cache.setObject("inspiVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Happies", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("happLikeVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func moveToShare() {
        cache.setObject("inspiVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Happies", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("uploadVC")
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func moveToFriends() {
        cache.setObject("inspiVC", forKey: "prevVC")
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
