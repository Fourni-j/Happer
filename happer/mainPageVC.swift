//
//  mainPageVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class mainPageVC: UIViewController {
    
    // MARK: - properties
    
    @IBOutlet weak var fbLogin: FBSDKLoginButtonFR!
    
    // MARK: - parent.methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - self.methods
    
    @IBAction func loginButton(sender: UIButton) {
        performSegueWithIdentifier("mainToLogin", sender: self)
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        performSegueWithIdentifier("mainToSignUp", sender: self)
    }
}