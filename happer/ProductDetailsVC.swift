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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(animated: Bool) {
        print("selected product : \(selectedProduct)")
    }
 
}

extension ProductDetailsVC : ProductEvent {

    func bidSuccess() {
        
    }
    
    func bidFailure(error: NSError) {
        
    }
    
}
