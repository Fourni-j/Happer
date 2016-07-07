//
//  loginVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class loginVC: UIViewController, UITextFieldDelegate {

    // MARK: - properties
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    var jsonData = NSDictionary()
    
    // MARK: - parent.methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.passwdField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
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
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - self.methods
    
    @IBAction func submit(sender: UIButton) {
        if loginField.text == "" || passwdField.text == "" {
            return
        }
        let login = loginField.text!.lowercaseString as NSString
        let passwd = passwdField.text!.lowercaseString as NSString
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/login.php")
        let body = "login=\(login)&passwd=\(passwd)"
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let postData: NSData = body.dataUsingEncoding(NSUTF8StringEncoding)!
        request.HTTPBody = postData
        let postLength: NSString = String(postData.length)
        
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var res = NSHTTPURLResponse()
        var urlData: NSData?
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            urlData = data! as NSData
            res = response as! NSHTTPURLResponse
            if res.statusCode >= 200 && res.statusCode < 300 {
                do
                {
                    self.jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
                catch
                {
                    print("Catch-Location:: 'loginPageVC' :: Serialization of server's response <jsonData>")
                    return
                }
            }
            else {
                print(res.statusCode)
                return
            }
            print(self.jsonData)
            let success = self.jsonData.valueForKey("id") as! NSInteger
            if (success > 0) {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let story = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = story.instantiateViewControllerWithIdentifier("inspiVC")
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            }
            else {
                print("FAIL")
            }
        })
        task.resume()
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
