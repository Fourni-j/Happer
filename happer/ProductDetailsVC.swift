//
//  ProductDetailsVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    var selectedProduct: Product!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bidView: BidView!
    @IBOutlet weak var infoButton: UIButton!
    
    var _displayDesc = false
    var displayDesc: Bool {
        get {
            return _displayDesc
        }
        set {
            _displayDesc = newValue
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        bidView.setup(false)
        imageView.af_setImageWithURL(selectedProduct.imageURL)
        imageView.contentMode = .ScaleAspectFit
        imageView.clipsToBounds = true
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
        title = "Détails produit"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func infoAction(sender: AnyObject) {
        displayDesc = !displayDesc
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        
    }
}

extension ProductDetailsVC : UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if displayDesc {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if displayDesc {
            let cell = tableView.dequeueReusableCellWithIdentifier("productDetailsDescCell", forIndexPath: indexPath) as! ProductDetailsDescTableViewCell
            cell.descTextView.text = selectedProduct.desc
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("productDetailsBidCell", forIndexPath: indexPath) as! ProductDetailsBidTableViewCell
            cell.nameLabel.text = "Thomas"
            cell.positionLabel.text = "\(indexPath.row + 1)"
            cell.rankLabel.text = "Advanced"
            return cell
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("productDetailsHeaderCell") as! ProductDetailsHeaderTableViewCell
        headerCell.backgroundColor = UIColor.lightGrayColor()
        if displayDesc {
            headerCell.titleLabel.text = "Description"
        } else {
            headerCell.titleLabel.text = "Dernières Happeuses"
        }
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
}

extension ProductDetailsVC : ProductEvent {

    func bidSuccess() {
        
    }
    
    func bidFailure(error: NSError) {
        
    }
    
}
