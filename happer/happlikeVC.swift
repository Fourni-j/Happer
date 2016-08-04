//
//  happlikeVC.swift
//  happer
//
//  Created by Josse on 29/06/2016.
//  Copyright © 2016 mjosse. All rights reserved.
//

import UIKit
import Foundation

class happlikeVC: UIViewController {

    // MARK : - NSUserDefault
    
    var cache = NSUserDefaults.standardUserDefaults()
    
    // MARK : - attributs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cache.setObject("happLikeVC", forKey: "currentVC")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButton(sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewControllerWithIdentifier(cache.objectForKey("prevVC") as! String)
        cache.setObject("happLikeVC", forKey: "prevVC")
        self.presentViewController(vc, animated: true, completion: nil)

    }

}
