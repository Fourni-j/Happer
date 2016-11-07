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
        menuOptions.append(["title":"Inspiration", "icon":"homeIcon", "identifier":"inspirationVC"])
        menuOptions.append(["title":"Partager", "icon":"homeIcon", "identifier":"shareVC"])
        menuOptions.append(["title":"Noter", "icon":"homeIcon", "identifier":"shareVC"])
        menuOptions.append(["title":"Produits", "icon":"homeIcon", "identifier":"productVC"])
        menuOptions.append(["title":"Mon dressing", "icon":"homeIcon", "identifier":"shareVC"])
        menuOptions.append(["title":"Mes Coups de coeur", "icon":"homeIcon", "identifier":"shareVC"])
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
        
        if let indexPathRow = path {
            self.tableView(self.tableView, didSelectRowAtIndexPath: indexPathRow)
        } else {
            closeMenu()
        }
        
    }
    
}


extension MenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellMenu")!
        
        cell.selectionStyle = .None
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clearColor()
        
        let labelTitle = cell.contentView.viewWithTag(101) as! UILabel
        labelTitle.text = menuOptions[indexPath.row]["title"]
        
        //        let imgIcon = cell.contentView.viewWithTag(100) as! UIImageView
        //        imgIcon.image = UIImage(named: menuOptions[indexPath.row]["icon"]!)
        
        return cell
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
        default:
            closeMenu()
            return
        }
        
        delegate?.didSelectMenuItem(routerURL)
    }
    
}
