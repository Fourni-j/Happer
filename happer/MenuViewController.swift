//
//  MenuViewController.swift
//  happer
//
//  Created by Charles Fournier on 02/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

protocol MenuDelegate {
//    func menuItemSelectedAtIndex(index : Int)
    func didSelectMenuItem(route: String)
    func menuClosed()
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menuOptions = [Dictionary<String,String>]()
    
    var delegate : MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.alwaysBounceVertical = false
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.darkGrayColor().CGColor
        view.backgroundColor = UIColor.clearColor()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tap))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateMenuOptions()
    }
    
    func updateMenuOptions() {
        menuOptions.append(["title":"Inspiration",
            "icon":"inspiIcon",
            "background":"inspiBack",
            "identifier":"inspirationVC"])
        menuOptions.append(["title":"Partager",
            "icon":"shareIcon",
            "background":"shareBack",
            "identifier":"shareVC"])
        menuOptions.append(["title":"Noter",
            "icon":"gradeIcon",
            "background":"gradeBack",
            "identifier":"shareVC"])
        menuOptions.append(["title":"Produits",
            "icon":"productIcon",
            "background":"productBack",
            "identifier":"productVC"])
        menuOptions.append(["title":"Mon dressing",
            "icon":"dressIcon",
            "background":"NONE",
            "identifier":"dressingVC"])
        menuOptions.append(["title":"Mes Coups de coeur",
            "icon":"likeIcon",
            "background":"NONE",
            "identifier":"dressingVC"])
        menuOptions.append(["title":"Ma Wishlist",
            "icon":"wishIcon",
            "background":"NONE",
            "identifier":"dressingVC"])
        menuOptions.append(["title":"Mon compte",
            "icon":"accountIcon",
            "background":"NONE",
            "identifier":"dressingVC"])
        tableView.reloadData()
    }
    
    
    func closeMenu() {
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRect(x: -self.view.frame.size.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clearColor()
        }) { (Bool) in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
            self.delegate?.menuClosed()
        }
    }
    
    func tap(tapGesture:UITapGestureRecognizer) {
        let location = tapGesture.locationInView(view)
        let path = tableView.indexPathForRowAtPoint(location)
        
        if path == nil {
            closeMenu()
        }
        
    }
    
}


extension MenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1, 2, 3:
            return 90.0
        case 8:
            return 220.0
        default:
            return 50.0 // 54.0 is true default height for a UITableViewCell
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count + 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0, 1, 2, 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("cellMenuMain")!
            
            cell.selectionStyle = .None
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clearColor()

            let labelTitle = cell.contentView.viewWithTag(101) as! UILabel
            labelTitle.text = menuOptions[indexPath.row]["title"]
            labelTitle.textColor = UIColor.whiteColor()

            let imgIcon = cell.contentView.viewWithTag(100) as! UIImageView
            imgIcon.image = UIImage(named: menuOptions[indexPath.row]["icon"]!)
            
            let imgBackground = cell.contentView.viewWithTag(102) as! UIImageView
            imgBackground.image = UIImage(named: menuOptions[indexPath.row]["background"]!)
            cell.contentView.sendSubviewToBack(imgBackground)

            return cell
        case 8:
            let cell = tableView.dequeueReusableCellWithIdentifier("cellFooter")!
            cell.selectionStyle = .None
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clearColor()

            let networkView = cell.contentView.viewWithTag(100)!
            networkView.backgroundColor = UIColor.clearColor()
//            networkView.layoutIfNeeded() // before width&heigth are 1000.0, after width is 19.5 and height is 75.0

            let borderTop = CALayer()
            borderTop.frame = CGRect(x: 0.0, y: 0.0, width: networkView.frame.width, height: 1.0)
            borderTop.borderColor = UIColor.blackColor().CGColor
            borderTop.borderWidth = 1.0
            networkView.layer.addSublayer(borderTop)

            let borderBottom = CALayer()
            borderBottom.frame = CGRect(x: 0.0, y: 74.0, width: networkView.frame.width, height: 1.0)
            // y var should be networkView.frame.height - 1 but networkView.frame.height return 1000 by default*/
            borderBottom.borderColor = UIColor.blackColor().CGColor
            borderBottom.borderWidth = 1.0
            networkView.layer.addSublayer(borderBottom)
    
            let networkLabel = networkView.viewWithTag(101) as! UILabel
            networkLabel.text = "Nos réseaux sociaux"

            let cgvButton = cell.contentView.viewWithTag(104) as! UIButton
            cgvButton.setTitle("CGV - CGU", forState: UIControlState.Normal)

            let mentionButton = cell.contentView.viewWithTag(105) as! UIButton
            mentionButton.setTitle("Mentions légales", forState: UIControlState.Normal)

            let faqButton = cell.contentView.viewWithTag(106) as! UIButton
            faqButton.setTitle("FAQ & service relation membres", forState: UIControlState.Normal)

            let decoButton = cell.contentView.viewWithTag(107) as! UIButton
            decoButton.setTitle("Deconnexion", forState: UIControlState.Normal)
            
            // for use all the button, it's necessary to create custom UITableViewCell

            let versionLabel = cell.contentView.viewWithTag(108) as! UILabel
            versionLabel.text = "Version 1.1.2"
            versionLabel.font = UIFont(name: (versionLabel.font?.fontName)!, size: 11)

            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("cellMenu")!

            cell.selectionStyle = .None
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clearColor()

            let labelTitle = cell.contentView.viewWithTag(101) as! UILabel
            labelTitle.text = menuOptions[indexPath.row]["title"]

            let imgIcon = cell.contentView.viewWithTag(100) as! UIImageView
            imgIcon.image = UIImage(named: menuOptions[indexPath.row]["icon"]!)

            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var routerURL: String
        switch indexPath.row {
        case 1:
            routerURL = "route://Happies/uploadVC#push"
        case 2:
            routerURL = "route://Happies/happLikeVC#push"
        case 3:
            routerURL = "route://Product/productCircleVC#push"
        case 4:
            routerURL = "route://UserPages/dressVC#push"
        case 5:
            routerURL = "route://UserPages/myLikeVC#push"
        case 6:
            routerURL = "route://UserPages/wishlistVC#push"
        case 7:
            routerURL = "route://UserPages/accountVC#push"
        case 8:
            closeMenu()
            return
        default:
            closeMenu()
            return
        }

        delegate?.didSelectMenuItem(routerURL)
    }
}
