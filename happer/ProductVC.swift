//
//  ProductVC.swift
//  happer
//
//  Created by Charles Fournier on 03/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import MagicSwiftBus

class ProductVC: UIViewController {

    var currentCircle = Circle.Unknown
    var productInteractor = ProductInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.title = currentCircle.rawValue
        ProductPresenter.register(self, events: .GetProductSuccess, .GetProductFailure, .BidSuccess, .BidFailure)
        productInteractor.getProducts()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        ProductPresenter.unregisterAll(self)
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


extension ProductVC : ProductEvent {

    func getProductSuccess() {
        print("Get Product Success")
        print(DAL.sharedInstance.readProduct(byId: 42))
    }
    
    func getProductFailure(error: NSError) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func bidSuccess() {
        
    }
    
    func bidFailure(error: NSError) {
        
    }
    
}

