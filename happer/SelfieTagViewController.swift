//
//  SelfieTagViewController.swift
//  happer
//
//  Created by Charles Fournier on 18/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class SelfieTagViewController: UIViewController {

    var cropedImage: UIImage!
    var selectedTag: Selfie.Category!
    @IBOutlet weak var taggableImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        taggableImageView.image = cropedImage
//        taggableImageView.contentMode = .
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        Session.sharedInstance.router.perform("route://Happies/brandTagViewController#push")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! BrandTagViewController
        destination.cropedImage = cropedImage
    }
    
 }

extension SelfieTagViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Selfie.Category.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "#" + Selfie.Category.init(value: row).value
    }
}
