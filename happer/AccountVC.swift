//
//  AccountVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class AccountVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var borderProfilView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstnameTextField.delegate = self
        self.nameTextField.delegate = self
        self.adressTextField.delegate = self
        self.postalCodeTextField.delegate = self
        self.cityTextField.delegate = self
        self.emailTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        let firstNamePaddingView = UIView(frame: CGRectMake(0.0, 0.0, 7.0, 21.0))
        firstNamePaddingView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        self.firstnameTextField.leftView = firstNamePaddingView
        self.firstnameTextField.leftViewMode = .Always
        let namePaddingView = UIView(frame: CGRectMake(0.0, 0.0, 7.0, 21.0))
        namePaddingView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        self.nameTextField.leftView = namePaddingView
        self.nameTextField.leftViewMode = .Always
        let adressPaddingView = UIView(frame: CGRectMake(0.0, 0.0, 7.0, 21.0))
        adressPaddingView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        self.adressTextField.leftView = adressPaddingView
        self.adressTextField.leftViewMode = .Always
        let postalCodePaddingView = UIView(frame: CGRectMake(0.0, 0.0, 7.0, 21.0))
        postalCodePaddingView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        self.postalCodeTextField.leftView = postalCodePaddingView
        self.postalCodeTextField.leftViewMode = .Always
        let cityPaddingView = UIView(frame: CGRectMake(0.0, 0.0, 7.0, 21.0))
        cityPaddingView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        self.cityTextField.leftView = cityPaddingView
        self.cityTextField.leftViewMode = .Always
        let emailPaddingView = UIView(frame: CGRectMake(0.0, 0.0, 7.0, 21.0))
        emailPaddingView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        self.emailTextField.leftView = emailPaddingView
        self.emailTextField.leftViewMode = .Always
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        borderProfilView.layer.cornerRadius = borderProfilView.frame.height / 2
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        borderProfilView.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 27/255, alpha: 1.0)
        profileImageView.image = UIImage(named: "profilePic")
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
        let postString: String = "prenom=\(firstnameTextField.text!)&nom=\(nameTextField.text!)&adresse=\(adressTextField.text!)&postalCode=\(postalCodeTextField.text!)&ville=\(cityTextField.text!)&email=\(emailTextField.text!)&borndate=\(strDate)"
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
