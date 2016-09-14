//
//  menuVC.swift
//  happer
//
//  Created by paul on 02/08/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class menuVC: UIViewController {

    let menuView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creatMenuView(navbarHeight: CGFloat) {
        menuView.frame = CGRect(
            x: self.view.frame.origin.x - 260,
            y: self.view.frame.origin.y + navbarHeight + 20,
            width: 260.0,
            height: self.view.frame.height - navbarHeight - 20)
        let inspisButton: UIButton = UIButton(type: .System)
        inspisButton.frame = CGRectMake(0.0, 0.0, 260.0, 80.0)
        inspisButton.addTarget(self, action: #selector(inspisAction), forControlEvents: .TouchUpInside)
        inspisButton.setTitle("inspiration", forState: .Normal)
        menuView.addSubview(inspisButton)
        let happieButton: UIButton = UIButton(type: .System)
        happieButton.frame = CGRectMake(0.0, 80.0, 260.0, 80.0)
        happieButton.addTarget(self, action: #selector(happieAction), forControlEvents: .TouchUpInside)
        happieButton.setTitle("happies", forState: .Normal)
        menuView.addSubview(happieButton)
        let cercleButton: UIButton = UIButton(type: .System)
        cercleButton.frame = CGRectMake(0.0, 160.0, 260.0, 80.0)
        cercleButton.addTarget(self, action: #selector(cercleAction), forControlEvents: .TouchUpInside)
        cercleButton.setTitle("produits", forState: .Normal)
        menuView.addSubview(cercleButton)
        let dressButton: UIButton = UIButton(type: .System)
        dressButton.frame = CGRectMake(0.0, 240.0, 260.0, 40.0)
        dressButton.addTarget(self, action: #selector(dressAction), forControlEvents: .TouchUpInside)
        dressButton.setTitle("mon dressing", forState: .Normal)
        menuView.addSubview(dressButton)
        let likesButton: UIButton = UIButton(type: .System)
        likesButton.frame = CGRectMake(0.0, 280.0, 260.0, 40.0)
        likesButton.addTarget(self, action: #selector(likesAction), forControlEvents: .TouchUpInside)
        likesButton.setTitle("mes coup de coeur", forState: .Normal)
        menuView.addSubview(likesButton)
        let wishsButton: UIButton = UIButton(type: .System)
        wishsButton.frame = CGRectMake(0.0, 320.0, 260.0, 40.0)
        wishsButton.addTarget(self, action: #selector(wishsAction), forControlEvents: .TouchUpInside)
        wishsButton.setTitle("ma wishlist", forState: .Normal)
        menuView.addSubview(wishsButton)
        let accountButton: UIButton = UIButton(type: .System)
        accountButton.frame = CGRectMake(0.0, 360.0, 260.0, 40.0)
        accountButton.addTarget(self, action: #selector(accountAction), forControlEvents: .TouchUpInside)
        accountButton.setTitle("mon compte", forState: .Normal)
        menuView.addSubview(accountButton)
        let reseauxView: UIView = UIView(frame: CGRect(x: 0.0, y: 400.0, width: 260.0, height: 80.0))
        let facebookButton: UIButton = UIButton(type: .System)
        facebookButton.frame = CGRectMake(65.0, 40.0, 30.0, 30.0)
        facebookButton.addTarget(self, action: #selector(facebookAction), forControlEvents: .TouchUpInside)
        facebookButton.layer.cornerRadius = facebookButton.frame.size.height / 2
        facebookButton.backgroundColor = UIColor.grayColor()
        reseauxView.addSubview(facebookButton)
        let instaButton: UIButton = UIButton(type: .System)
        instaButton.frame = CGRectMake(115.0, 40.0, 30.0, 30.0)
        instaButton.addTarget(self, action: #selector(instaAction), forControlEvents: .TouchUpInside)
        instaButton.layer.cornerRadius = instaButton.frame.size.height / 2
        instaButton.backgroundColor = UIColor.grayColor()
        reseauxView.addSubview(instaButton)
        let youTubeButton: UIButton = UIButton(type: .System)
        youTubeButton.frame = CGRectMake(165.0, 40.0, 30.0, 30.0)
        youTubeButton.addTarget(self, action: #selector(youTubeAction), forControlEvents: .TouchUpInside)
        youTubeButton.layer.cornerRadius = youTubeButton.frame.size.height / 2
        youTubeButton.backgroundColor = UIColor.grayColor()
        reseauxView.addSubview(youTubeButton)
        reseauxView.backgroundColor = UIColor.whiteColor()
        menuView.addSubview(reseauxView)
        menuView.backgroundColor = UIColor.grayColor()
        view.addSubview(menuView)
    }

    func inspisAction(sender: UIButton!) {
        print("inspiration")
        if self.dynamicType === inspirationVC.self {
            print("You are alredy on inspirationVC")
        } else {
            move("Main", dest: "inspiVC")
        }
    }

    func happieAction(sender: UIButton!) {
        print("happie")
    }

    func cercleAction(sender: UIButton!) {
        print("produit")
        if self.dynamicType === cerclesVC.self {
            print("You are alredy on cerclesVC")
        } else {
            move("Main", dest: "cerclesVC")
        }
    }

    func dressAction(sender: UIButton!) {
        print("dressing")
        move("UserPages", dest: "dressVC")
    }

    func likesAction(sender: UIButton!) {
        print("coup de coeur")
        move("UserPages", dest: "myLikeVC")
    }

    func wishsAction(sender: UIButton!) {
        print("wishlist")
        move("UserPages", dest: "wlVC")
    }

    func accountAction(sender: UIButton!) {
        print("compte")
        move("UserPages", dest: "accountVC")
    }

    func facebookAction(sender: UIButton) {
        print("facebook")
    }

    func instaAction(sender: UIButton!) {
        print("instagram")
    }

    func youTubeAction(sender: UIButton!) {
        print("youtube")
    }

    func move(storyboard: String, dest: String) {
        let story = UIStoryboard.init(name: storyboard, bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier(dest)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func toggleMenu() {
        if menuView.frame.origin.x == 0 {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.menuView.frame = CGRectMake(
                    self.menuView.frame.origin.x - 260.0,
                    self.menuView.frame.origin.y,
                    self.menuView.frame.size.width,
                    self.menuView.frame.size.height)
            })
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.menuView.frame = CGRectMake(
                    self.menuView.frame.origin.x + 260.0,
                    self.menuView.frame.origin.y,
                    self.menuView.frame.size.width,
                    self.menuView.frame.size.height)
            })
        }
    }
}
