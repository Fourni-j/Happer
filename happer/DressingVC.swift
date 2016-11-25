//
//  DressingVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class DressingVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var notifButton: UIButton!
    @IBOutlet weak var dressingCollectionView: UICollectionView!
    //let reuseIdentifier = "dressingCell"
    var items = ["1", "2", "3", "4", "5", "6", "7", "8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dressingCollectionView.delegate = self
        dressingCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn1.setImage(UIImage(named: "accountIcon"), forState: .Normal)
        btn1.addTarget(self, action: #selector(DressingVC.moveToAccount), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn1)

        notifButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 2, 4)
        notifButton.layer.borderWidth = 1.0
        notifButton.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7).CGColor
        creditLabel.adjustsFontSizeToFitWidth = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = "Mon dressing"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.dressingCollectionView.frame.width, height: 200)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dressingCell", forIndexPath: indexPath) as! DressingCollectionViewCell
        cell.cellLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.yellowColor()
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func moveToAccount() {
        Session.sharedInstance.router.perform("route://UserPages/accountVC#push", sender: self)
    }

    @IBAction func notifAction(sender: UIButton) {
        print("====> NOTIF BUTTON PRESSED <====")
    }

    @IBAction func likesAction(sender: UIButton) {
        Session.sharedInstance.router.perform("route://UserPages/myLikeVC#push", sender: self)
    }
    
    @IBAction func uploadAction(sender: UIButton) {
        Session.sharedInstance.router.perform("route://Happies/uploadVC#push", sender: self)
    }
}
