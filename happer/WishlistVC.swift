//
//  WishlistVC.swift
//  happer
//
//  Created by paul on 25/11/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class WishlistVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var wishlistCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("wishlistCollectionViewCell", forIndexPath: indexPath)

        cell.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        let productImageView = cell.contentView.viewWithTag(101) as! UIImageView
        productImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://s3.eu-central-1.amazonaws.com/happer/products/pictures/000/000/004/medium/03820-chaussures-palladium-palavil-hi-beige-vue-exterieure.png?1479289877")!)!)
        let brandLabel = cell.contentView.viewWithTag(102) as! UILabel
        brandLabel.text = "Palladium"
        let descLabel = cell.contentView.viewWithTag(103) as! UILabel
        descLabel.text = "Palladium adapte à la ville sa mythique chaussure Baggy avec cette Palaville et sa semelle moderne et légère. Toujours en cuir robuste, elle affrontera toutes les conditions en gardant vos pieds au sec. En cuir beige et col de cheville textile, la Palaville offre un nouveau confort à la mythique chaussure Palladium. Pensée pour la ville, c'est l'occasion de s'offrir un nouveau style !"
        let priceLabel = cell.contentView.viewWithTag(105) as! UILabel
        priceLabel.text = "90.0"
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 200.0)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell \(indexPath.item)!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
