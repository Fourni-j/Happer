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
    @IBOutlet weak var topView: TopView!
    
    var resultProducts: Results<Product>!
    var selectedProduct: Product!
    var currentCircle: Circle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        topView.setup(nil)
        topView.select(Circle.init(value: self.title!))
        topView.fillExp(3, neededExp: 4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("didAppear")
//        topView.select(currentCircle)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func buildFromCircle(circle: Circle) {
        resultProducts = DAL.sharedInstance.readProduct(byCircle: circle)
        currentCircle = circle
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
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("productCollectionViewCell", forIndexPath: indexPath) as! ProductCollectionViewCell
            cell.setup(resultProducts[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("productSmallCollectionViewCell", forIndexPath: indexPath) as! ProductSmallCollectionViewCell
            cell.setup(resultProducts[indexPath.row])
            return cell
        }
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
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width - 20, height: 200.0)
        } else {
            return CGSize(width: collectionView.frame.width / 2 - 15, height: 250.0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedProduct = resultProducts[indexPath.row]
        Session.sharedInstance.router.perform("route://Product/productDetailsVC#push", sender: self)
    }
}
