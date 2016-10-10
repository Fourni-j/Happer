//
//  ProductVC.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import MagicSwiftBus
import RealmSwift

class ProductVC: UIViewController {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var resultProducts: Results<Product>!
    var selectedProduct: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func buildFromCircle(circle: Circle) {
        resultProducts = DAL.sharedInstance.readProduct(byCircle: circle)
        if productCollectionView != nil {
            productCollectionView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? ProductDetailsVC {
            destinationVC.selectedProduct = selectedProduct
        }
    }
}

extension ProductVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (resultProducts != nil) {
            return resultProducts.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("productCollectionViewCell", forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        cell.brandLabel.text = resultProducts[indexPath.row].brand
        cell.descriptionLabel.text = resultProducts[indexPath.row].desc
        cell.priceLabel.text = "Price : \(resultProducts[indexPath.row].price)€"
        cell.imageView.af_setImageWithURL(resultProducts[indexPath.row].imageURL)
        cell.cellState = resultProducts[indexPath.row].state
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader :
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "productHeader", forIndexPath: indexPath)
            return headerView
        default:
            assert(false, "unexpected element kind")
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200.0)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedProduct = resultProducts[indexPath.row]
        Session.sharedInstance.router.perform("route://Product/productDetailsVC#push", sender: self)
    }
    
}
