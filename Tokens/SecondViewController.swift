//
//  SecondViewController.swift
//  Tokens
//
//  Created by Katlyn Schwaebe on 10/1/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let API_URL = "https://api.instagram.com/v1/"
    let CLIENT_ID = "d4a533f95b984066a05ec19230577c35"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func instaConnect(sender: AnyObject) {
        let AUTH_URL = "https://instagram.com/oauth/authorize/?client_id=" + CLIENT_ID + "&redirect_uri=tokens://tokens.com&response_type=token"
        UIApplication.sharedApplication().openURL(NSURL(string: AUTH_URL))
        
    }
    @IBAction func getMyFeed(sender: AnyObject) {
        
        instaRequest("users/self/feed", parameter: "count=5")
    }

    @IBAction func findWaldo(sender: AnyObject) {
        instaRequest("users/search", parameter: "q=waldo")
        
    }
    func instaRequest(endpoint: String, parameter: String) {
        var request = NSURLRequest(URL: NSURL(string: API_URL + endpoint + "?oauth_token=" + FS_TOKEN + "&" + parameter))
        println(request.URL.absoluteString)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            var resultInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as [String:AnyObject]
            
            
            println(resultInfo)
            
            var igTVC = self.storyboard!.instantiateViewControllerWithIdentifier("instaTVC") as IGTableViewController
            igTVC.items = resultInfo["data"]! as [AnyObject]
            self.presentViewController(igTVC, animated: true, completion: nil)
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
