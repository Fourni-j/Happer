//
//  SelfieViewController.swift
//  happer
//
//  Created by Charles Fournier on 18/10/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class SelfieViewController: UIViewController {

    let imagePicker = UIImagePickerController()
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! CropVC
        destination.pickedImage = pickedImage
    }

    @IBAction func loadPicture(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: { UIApplication.sharedApplication().statusBarHidden = true })
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.cameraCaptureMode = .Photo
            presentViewController(imagePicker, animated: true, completion: { UIApplication.sharedApplication().statusBarHidden = true })
        } else {
            let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}

extension SelfieViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        pickedImage = image
        dismissViewControllerAnimated(false, completion: {() -> Void in self.performSegueWithIdentifier("partageToCrop", sender: nil)})
    }
}
