//
//  BaseMenuViewController.swift
//  happer
//
//  Created by Charles Fournier on 02/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class BaseMenuViewController: UIViewController, MenuDelegate {
    
    private var isToggle = false
    
    private var menuWidth : CGFloat = 100.0
    private var menuHeight : CGFloat = 100.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuWidth = view.frame.size.width
        menuHeight = view.frame.size.height
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(toggleMenu))
        view.addGestureRecognizer(panGestureRecognizer)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if (isToggle) {
            closeMenu()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelectMenuItem(route: String) {
        closeMenu()
        Session.sharedInstance.router.perform(route, sender: self)
    }
    
    func menuClosed() {
        isToggle = false
    }
    
    func addSlideMenuButton() {
        let btnShowMenu = UIButton(type: UIButtonType.System)
        btnShowMenu.setImage(self.defaultMenuImage(), forState: .Normal)
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        btnShowMenu.addTarget(self, action: #selector(toggleMenu), forControlEvents: UIControlEvents.TouchUpInside)
        
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.blackColor().setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.whiteColor().setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func toggleMenu() {
        
        if isToggle {
            closeMenu()
            return
        }
        
        let menuVC = self.storyboard!.instantiateViewControllerWithIdentifier("menuViewController") as! MenuViewController
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: menuHeight)
        UIView.animateWithDuration(0.3) {
            menuVC.view.frame = CGRect(x: 0, y: 0, width: self.menuWidth, height: self.menuHeight)
        }
        isToggle = true
    }
    
    func closeMenu() {
        isToggle = false
        let menuView = view.subviews.last!
        UIView.animateWithDuration(0.3, animations: {
            var frameMenu = menuView.frame
            frameMenu.origin.x = -self.menuWidth
            menuView.frame = frameMenu
            menuView.layoutIfNeeded()
            menuView.backgroundColor = UIColor.clearColor()
            }, completion: { (Bool) in
                menuView.removeFromSuperview()
        })
    }
    
}
