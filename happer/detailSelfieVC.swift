//
//  detailSelfieVC.swift
//  happer
//
//  Created by Josse on 05/08/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class detailSelfieVC: UIViewController {

    // MARK: - NSUserDefault
    
    var cache = NSUserDefaults.standardUserDefaults()
    
    // MARK: - attributs
    
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var nbLikeLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var imageSelfie: UIImageView!
    
    // MARK: - subviews

    var custom: happieView = happieView()
    var filter: UIView = UIView()
    
    // MARK: - Donnees selfie a detailler
    
    var indexSelected = 0
    var selfie = selfieClass(ownerID: 0, nbLike: 0, rate: 0, id: 0, categoryName: "default", path: "ec2-52-49-149-140.eu-west-1.compute.amazonaws.com/uploads/selfie20.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catLabel.text = self.selfie.getCategory()
        self.nbLikeLabel.text = String(self.selfie.getNbLike())
        self.ratingView.rating = Float(self.selfie.getRate())
        self.imageSelfie.image = self.selfie.getImage()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(detailSelfieVC.moveToHappLike), name: "happLike", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(detailSelfieVC.moveToShare), name: "share", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(detailSelfieVC.moveToFriends), name: "friends", object: nil)
        
        let viewW = self.view.frame.width
        let viewH = self.view.frame.height
        
        let tapOut = UITapGestureRecognizer(target: self, action: #selector(detailSelfieVC.dismissHappieView))
        
        // préparation vue happies et filtre
        
        self.custom = happieView(frame: CGRect(x: (viewW / 2 - 80), y: (viewH / 2), width: 160, height: 130))
        self.filter = UIView(frame: CGRect(x: 0, y: 0, width: viewW, height: viewH))
        self.filter.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.filter.addGestureRecognizer(tapOut)
        self.view.addSubview(filter)
        self.filter.addSubview(custom)
        self.filter.hidden = true
        
        let happerL = happerLogo(frame: CGRect(x: (viewW / 2 - 25), y: (viewH - 80), width: 50, height: 50))
        happerL.button.addTarget(self, action: #selector(detailSelfieVC.callHappieView), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(happerL)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goBack" {
            let destination = segue.destinationViewController as! filactuVC
            destination.indexSelected = self.indexSelected
        }
    }

    @IBAction func backButton(sender: UIButton) {
        performSegueWithIdentifier("goBack", sender: self)
    }
    
    func moveToHappLike() {
        cache.setObject("actuVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("happLikeVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func moveToShare() {
        cache.setObject("actuVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("uploadVC")
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func moveToFriends() {
        cache.setObject("actuVC", forKey: "prevVC")
        let story = UIStoryboard.init(name: "Main", bundle: nil)
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
