//
//  monCompteVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class monCompteVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var prenomLabel: UITextField!
    @IBOutlet weak var nomLabel: UITextField!
    @IBOutlet weak var adresseLabel: UITextField!
    @IBOutlet weak var postalCodeLabel: UITextField!
    @IBOutlet weak var villeLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prenomLabel.delegate = self
        self.nomLabel.delegate = self
        self.adresseLabel.delegate = self
        self.postalCodeLabel.delegate = self
        self.villeLabel.delegate = self
        self.emailLabel.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginVC.dismissKeyboard))
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
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier("dressVC")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func modifierAction(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        let postString: String = "prenom=\(prenomLabel.text!)&nom=\(nomLabel.text!)&adresse=\(adresseLabel.text!)&postalCode=\(postalCodeLabel.text!)&ville=\(villeLabel.text!)&email=\(emailLabel.text!)&borndate=\(strDate)"
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
