//
//  HashtagVC.swift
//  happer
//
//  Created by paul on 29/08/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class HashtagVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: TaggableImageView!
    var cropedImage: UIImage!
    @IBOutlet weak var OOTD: UIButton!
    var ootdLeftBar: UIView!
    var ootdRightBar: UIView!
    @IBOutlet weak var OOTN: UIButton!
    var ootnLeftBar: UIView!
    var ootnRightBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        designFrame()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HashtagVC.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HashtagVC.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func designFrame() {
        imageView.image = cropedImage
        OOTD.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        OOTD.layer.masksToBounds = true
        ootdLeftBar = UIView(frame: CGRectMake(-5, 0, 10, OOTD.frame.size.height))
        ootdLeftBar.backgroundColor = UIColor.blackColor()
        OOTD.addSubview(ootdLeftBar)
        ootdRightBar = UIView(frame: CGRectMake(OOTD.frame.size.width - 5, 0, 10, OOTD.frame.size.height))
        ootdRightBar.backgroundColor = UIColor.blackColor()
        OOTD.addSubview(ootdRightBar)
        OOTN.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        OOTN.layer.masksToBounds = true
        ootnLeftBar = UIView(frame: CGRectMake(-5, 0, 10, OOTN.frame.size.height))
        ootnLeftBar.backgroundColor = UIColor.blackColor()
        OOTN.addSubview(ootnLeftBar)
        ootnRightBar = UIView(frame: CGRectMake(OOTN.frame.size.width - 5, 0, 10, OOTN.frame.size.height))
        ootnRightBar.backgroundColor = UIColor.blackColor()
        OOTN.addSubview(ootnRightBar)
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y = -keyboardSize.height + imageView.frame.origin.y
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        imageView.endEditing(true)
    }
    
    
    @IBAction func OOTDButton(sender: UIButton) {
        if ootdLeftBar.frame.origin.x == -5 && ootdRightBar.frame.origin.x == OOTD.frame.size.width - 5 {
            ootdLeftBar.frame.origin.x += 5
            ootdRightBar.frame.origin.x -= 5
            OOTD.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        }
        if ootnLeftBar.frame.origin.x == 0 && ootnRightBar.frame.origin.x == OOTN.frame.size.width - 10 {
            ootnLeftBar.frame.origin.x -= 5
            ootnRightBar.frame.origin.x += 5
            OOTN.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        }
    }

    @IBAction func OOTNButton(sender: UIButton) {
        if ootnLeftBar.frame.origin.x == -5 && ootnRightBar.frame.origin.x == OOTN.frame.size.width - 5 {
            ootnLeftBar.frame.origin.x += 5
            ootnRightBar.frame.origin.x -= 5
            OOTN.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        }
        if ootdLeftBar.frame.origin.x == 0 && ootdRightBar.frame.origin.x == OOTD.frame.size.width - 10 {
            ootdLeftBar.frame.origin.x -= 5
            ootdRightBar.frame.origin.x += 5
            OOTD.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05)
        }
    }

    @IBAction func saveSelfieButton(sender: UIButton) {
        if ootdLeftBar.frame.origin.x == -5 && ootnLeftBar.frame.origin.x == -5 {
            print("Need to select one of the hashtag (#OOTD or #OOTN)")
        } else {
            var postString: String = String()
            if ootdLeftBar.frame.origin.x == 0 {
                postString += "OutfitOfThe=Day"
            } else {
                postString += "OutfitOfThe=Night"
            }
//            var i: Int = 0
//            while let area:[String: CGPoint] = filledArea[i] {
//                postString += "&label\(i + 1)=\(textFields[i].text!)&sp\(i + 1)X=\(area["startPoint"]!.x)&sp\(i + 1)Y=\(area["startPoint"]!.y)&ep\(i + 1)X=\(area["endPoint"]!.x)&ep\(i + 1)Y=\(area["endPoint"]!.y)"
//                i += 1
//            }
            print(postString)
            /*
             var jsonData = NSDictionary()
             let postNSString = NSString(string: postString)
             let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/adduser.php")
             let request = NSMutableURLRequest(URL :url!)
             let session = NSURLSession.sharedSession()
             request.HTTPMethod = "POST"
             let postData: NSData = postNSString.dataUsingEncoding(NSUTF8StringEncoding)!
             request.HTTPBody = postData
             let postLength: NSString = String(postData.length)
             request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
             request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
             request.setValue("application/json", forHTTPHeaderField: "Accept")
             var urlData: NSData?
             let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
             urlData = data! as NSData
             let res = response as! NSHTTPURLResponse
             if res.statusCode >= 200 && res.statusCode < 300 {
             do {
             jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
             } catch {
             print("Catch-Location:: 'loginPageVC' :: Serialization of server's response <jsonData>")
             return
             }
             } else {
             print(res.statusCode)
             return
             }
             print(jsonData)
             let success = jsonData.valueForKey("success") as! NSInteger
             if (success > 0) {
             print("SUCCESS")
             self.performSegueWithIdentifier("signUpToMain", sender: self)
             } else {
             print("FAIL")
             }
             })
             task.resume()
             */
        }
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
