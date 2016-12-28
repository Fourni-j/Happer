//
//  LoginVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    var jsonData = NSDictionary()
    var authentInteractor = AuthentInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.passwdField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)

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
        AuthentPresenter.register(self, events: .ConnectSuccess, .ConnectFailure)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        AuthentPresenter.unregisterAll(self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submit(sender: UIButton) {
        if loginField.text == "" || passwdField.text == "" {
            return
        }
        authentInteractor.connection(loginField.text!, pass: passwdField.text!)
    }
}

extension LoginVC : AuthentEvent {
    func connectSuccess() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func connectFailure(error: NSError) {
        let alertController = UIAlertController(title: "Echec de connexion", message: "mail ou mot de passe incorrect", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            (action: UIAlertAction!) in
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
