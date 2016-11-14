//
//  NewsFeedVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage
import RealmSwift

class NewsFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var resultSelfies: Results<Selfie>!
    var newsFeedInteractor = NewsFeedInteractor()
    var currentCategory = Selfie.Category.init(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        NewsFeedPresenter.register(self, events: .GetSelfiesSuccess, .GetSelfiesFailure)
        newsFeedInteractor.getSelfies()
        title = currentCategory.value
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NewsFeedPresenter.unregisterAll(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSelfies != nil {
            return resultSelfies.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCellWithIdentifier("newsFeedCell", forIndexPath: indexPath) as! NewsFeedCell
        let selfie = resultSelfies[indexPath.row]
        cell.cellRating.rating = Float(selfie.rating)
        cell.cellImage.af_setImageWithURL(selfie.imageURL)
        cell.cellLikeCount.text = "\(selfie.nbLike)"
        cell.cellImage.userInteractionEnabled = false
        cell.cellImage.clipsToBounds = true
        cell.cellImage.contentMode = .ScaleAspectFill
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as!  NewsFeedCell
        cell.cellImage.tagHidden = !cell.cellImage.tagHidden
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}

extension NewsFeedVC : NewsFeedEvent {
    
    func getSelfiesSuccess() {
        resultSelfies = DAL.sharedInstance.readSelfie(byCategory: currentCategory)
        
        if resultSelfies.count == 0 {
            let alertController = UIAlertController(title: "Empty category", message: "Try again later", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default) {
                (action: UIAlertAction!) in
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        table.reloadData()
        print(resultSelfies)
    }
    
    func getSelfiesFailure(error: NSError) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action: UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
