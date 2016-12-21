//
//  FriendsVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class FriendsVC: UIViewController {
    
    var friends = [FacebookUsers]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 1...36 {
            let friend = FacebookUsers()
            friend.id = "\(index)"
            friend.isSelected = false;
            friend.name = "Jean"
            friends.append(friend)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension FriendsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("askFriendCell", forIndexPath: indexPath) as! AskFriendCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.layer.cornerRadius = cell.frame.size.height / 2
        cell.setup(friends[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! AskFriendCollectionViewCell
        cell.cellSelected = !cell.cellSelected
        friends[indexPath.row].isSelected = cell.cellSelected
    }
}
