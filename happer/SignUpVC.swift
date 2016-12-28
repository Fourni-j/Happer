//
//  SignUpVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    // MARK: - properties
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    @IBOutlet weak var confpassField: UITextField!
    var authentInteractor = AuthentInteractor()
    // MARK: - parent.methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.mailField.delegate = self
        self.passwdField.delegate = self
        self.confpassField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view, typically from a nib.
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "loginBackground")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AuthentPresenter.register(self, events: .SubscribeSuccess, .SubscribeFailure, .ConnectSuccess, .ConnectFailure)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        AuthentPresenter.unregisterAll(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    // MARK: - self.methods

    func checkFields() -> Bool {
        if loginField.text == "" || mailField.text == "" || passwdField.text == "" || confpassField.text == "" {
            return false
        }
        return true
    }
    
    @IBAction func submit(sender: UIButton) {
        if !checkFields() {
            loginField.text = ""
            mailField.text = ""
            passwdField.text = ""
            confpassField.text = ""
            return;
        }
        if passwdField.text!.lowercaseString == confpassField.text!.lowercaseString {
            print("match")
        }
        else {
            loginField.text = ""
            mailField.text = ""
            passwdField.text = ""
            confpassField.text = ""
            return
        }
        authentInteractor.subscribe(mailField.text!, password: passwdField.text!, confirm: confpassField.text!)
        
    }
}

extension SignUpVC : AuthentEvent {
    func subscribeSuccess() {
        authentInteractor.connection(mailField.text!, pass: passwdField.text!)
    }
    
    func subscribeFailure(error: NSError) {
        let alertController = UIAlertController(title: "Echec d'inscription", message: "Adresse mail deja existante", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action: UIAlertAction!) in
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func connectSuccess() {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func connectFailure(error: NSError) {
        let alertController = UIAlertController(title: "Echec de connexion", message: "mail ou mot de passe incorrect", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action: UIAlertAction!) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
