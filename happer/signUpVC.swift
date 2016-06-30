//
//  signUpVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {

    // MARK: - properties
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    @IBOutlet weak var confpassField: UITextField!

    // MARK: - parent.methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - self.methods

    @IBAction func submit(sender: UIButton) {
        
    }
    @IBAction func back(sender: UITapGestureRecognizer) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("mainPage") as! mainPageVC
        self.presentViewController(vc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
