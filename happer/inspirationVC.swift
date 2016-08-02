//
//  inspirationVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class inspirationVC: menuVC, UITabBarDelegate, UITableViewDataSource {

    // MARK : - attributs
    
    var categories: [inspiClass] = []
    var indexSelected: Int = 0
    let viewID = "inspiVC"

    @IBOutlet weak var catTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.creatMenuView(57)
        initCat()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - self.methods
    
    func initCat() {
        let ootd = inspiClass(name: "Tenue de Jour", keyWord: "ootd")
        let ootn = inspiClass(name: "Tenue de Nuit", keyWord: "ootn")
        let sacs = inspiClass(name: "Sacs", keyWord: "sacs")
        let accessoires = inspiClass(name: "Accessoires", keyWord: "accessoires")
        let chaussures = inspiClass(name: "Chaussures", keyWord: "chaussures")
        let decontracte = inspiClass(name: "Decontracté", keyWord: "decontracte")
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
    
    @IBAction func menuButton(sender: UIButton) {
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
            let destination = segue.destinationViewController as! filactuVC
            destination.indexSelected = indexSelected
            destination.prevID = viewID
        }
  
    }

}
