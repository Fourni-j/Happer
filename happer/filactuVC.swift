//
//  filactuVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit

class filactuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK : - attributs
    @IBOutlet weak var mylabel: UILabel!
    var jsonData = NSDictionary()

    var indexSelected: Int = 0
    let catTab: [String] = ["ootd", "ootn", "sacs", "accessoires", "chaussures", "decontracte"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.mylabel.text = catTab[indexSelected]
        getSelfies()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - tableView methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

    func getSelfies() {
        let category = mylabel.text! as NSString
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://ec2-52-49-149-140.eu-west-1.compute.amazonaws.com:80/byCategory.php")
        
        let body = "category=\(category)"
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST"
        
        let postData : NSData = body.dataUsingEncoding(NSUTF8StringEncoding)!
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
            if res.statusCode >= 200 && res.statusCode < 300
            {
                do
                {
                    self.jsonData = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                }
                catch
                {
                    print("Erreur dans le catch sur FilActu")
                    return
                }
            }
            else
            {
                print("Erreur, statusCode : ")
                print(res.statusCode)
                return
            }
            print(self.jsonData)
        })
        task.resume()
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
