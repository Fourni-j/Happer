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
    
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bidView: BidView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var headerSize : CGFloat = 30.0
    var borderHeight : CGFloat = 2.0
    var borderInset : CGFloat = 10
    
    
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
        tableView.separatorStyle = .None
        
        brandLabel.text = selectedProduct.brand
        priceLabel.text = "\(Int(selectedProduct.price))€"
        descLabel.text = "" // Need update
        
        let userTest = User()
        userTest.circle = .Platine
        Session.sharedInstance.user = userTest
        
        topView.setup(Session.sharedInstance.user)
        topView.select(selectedProduct.circle)
        
        bidView.updateFillWith(completedTime: 190, totalTime: 240) // Exemple
        title = "Détails produit"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func infoAction(sender: AnyObject) {
        displayDesc = !displayDesc
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        let shareContent = "\(selectedProduct.title) disponible sur l'application Happer."
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
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
            cell.nameLabel.font = UIFont.systemFontOfSize(15)
            cell.positionLabel.text = "\(indexPath.row + 1)"
            cell.positionLabel.font = UIFont.systemFontOfSize(15)
            cell.rankLabel.text = "Advanced"
            cell.rankLabel.font = UIFont.systemFontOfSize(15)
            return cell
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("productDetailsHeaderCell") as! ProductDetailsHeaderTableViewCell
        headerCell.backgroundColor = UIColor.whiteColor()
        if displayDesc {
            headerCell.titleLabel.text = "Description"
        } else {
            headerCell.titleLabel.text = "Dernières Happeuses"
        }

        headerCell.titleLabel.font = UIFont.systemFontOfSize(15)
        
        let borderWidth = self.view.frame.size.width - borderInset * 2
        
        let topBorder = UIView(frame: CGRectMake(borderInset, 0, borderWidth, borderHeight))
        topBorder.backgroundColor = UIColor.blackColor()
        headerCell.contentView.addSubview(topBorder)
        
        let bottomBorder = UIView(frame: CGRectMake(borderInset, headerSize - borderHeight - 1, borderWidth, borderHeight))
        bottomBorder.backgroundColor = UIColor.blackColor()
        headerCell.contentView.addSubview(bottomBorder)
    
        return headerCell
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerSize
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if displayDesc {
            return self.tableView.frame.size.height - headerSize
        } else {
            return 30
        }
    }
    
}

extension ProductDetailsVC : ProductEvent {

    func bidSuccess() {
        
    }
    
    func bidFailure(error: NSError) {
        
    }
    
}
