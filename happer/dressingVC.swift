//
//  dressingVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class dressingVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var dressingCollectionView: UICollectionView!
    let reuseIdentifier = "dressingCell"
    var items = ["1", "2", "3", "4", "5", "6", "7", "8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dressingCollectionView.delegate = self
        dressingCollectionView.dataSource = self
        // Do any additional setup after loading the view.
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

    @IBAction func backButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("inspiVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func accountButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("accountVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func LikeButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("myLikeVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func UploadButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "Happies", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("uploadVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
