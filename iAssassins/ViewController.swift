//
//  ViewController.swift
//  iAssassins
//
//  Created by Marion Xu on 10/17/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import UIKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            print("logged in")
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            print("not logged in")
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile"]
            loginView.delegate = self
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToViewOtherController(segue:UIStoryboardSegue) {
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        //let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("createJoin")
        
        //self.showViewController(vc as! UIViewController, sender: vc)
        returnUserData()
        performSegueWithIdentifier("segue1", sender: nil)
                    print("end")
        
        if ((error) != nil)
        {
            
            // Process error
        }
        else if result.isCancelled {
            
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            //if result.grantedPermissions.contains("email")
            //{
                // Do work
            //}
            

            //performSegueWithIdentifier("unwindToViewOtherController", sender: self)
            
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let params = ["fields": "public_profile, first_name, last_name"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userID : NSString = result.valueForKey("id") as! NSString
                print("User id is: \(userID)")
                let firstName : NSString = result.valueForKey("first_name") as! NSString
                let lastName : NSString = result.valueForKey("last_name") as! NSString
                let firstAndLast = (firstName as String) + (lastName as String)
                print(firstAndLast)
                let selfPhotoURL = "http://graph.facebook.com/\(userID)/picture?type=large"
                self.addUser(firstAndLast, uid: userID, selfPhotoURL: selfPhotoURL, targetPhotoURL: "")
            }
        })
    }
    
    func addUser(firstAndLast:NSString, uid:NSString, selfPhotoURL:String, targetPhotoURL:String) -> Bool {
        let request = NSMutableURLRequest(URL: NSURL(string: "ec2-54-186-237-21.us-west-2.compute.amazonaws.com:5433/addUser")!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let params = ["fiD": "CAAIob3CfZAq4BAFE02nGxKT47GXBKVVSrZCPjZAJfHpDlw336ESr61oamX0tMD0CLmYlvq3T9OcTh19JMpdmvURPBaFlUL3EhalK79cOK8SExupFVKaKjlc3Lvib7ZB18RGqNx5rCjnRq5DZCRHE3ExTfgZAsfnc7Y2AmIvZCrwZAgh6yaq6Gsgd0hkWF4oPLGeYDBmOIcnV13Lu8wWeM3Yl",
            "name": firstAndLast,
            "uid": uid,
            "beaconID": "",
            "photoBytea" : selfPhotoURL,
            ] as Dictionary<String, AnyObject>
        let NewDictionary : NSData = NSKeyedArchiver.archivedDataWithRootObject(params)
        let json = try! NSJSONSerialization.JSONObjectWithData(NewDictionary, options: .MutableContainers) as? [String:AnyObject]

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                let success = parseJSON["success"] as? Int
                print("Success: \(success)")
            }
            
        })
        
        task.resume()
        return true
    }
}


