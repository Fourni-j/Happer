//
//  AccountVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class AccountVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstnameLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var adressLabel: UITextField!
    @IBOutlet weak var postalCodeLabel: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstnameLabel.delegate = self
        self.nameLabel.delegate = self
        self.adressLabel.delegate = self
        self.postalCodeLabel.delegate = self
        self.cityLabel.delegate = self
        self.emailLabel.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func backButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "UserPages", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("dressVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func modifierAction(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        let postString: String = "prenom=\(firstnameLabel.text!)&nom=\(nameLabel.text!)&adresse=\(adressLabel.text!)&postalCode=\(postalCodeLabel.text!)&ville=\(cityLabel.text!)&email=\(emailLabel.text!)&borndate=\(strDate)"
        print(postString)
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
