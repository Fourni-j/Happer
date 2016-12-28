//
//  BrandTagViewController.swift
//  happer
//
//  Created by Charles Fournier on 21/12/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class BrandTagViewController: UIViewController {

    @IBOutlet weak var taggableImageView: TaggableImageView!
    var cropedImage: UIImage!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taggableImageView.image = cropedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func DoneAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "Partage du selfie", message: "Votre selfie est maintenant en attente de notation", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action: UIAlertAction!) in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true) { 
        }

    }
    
    
}
