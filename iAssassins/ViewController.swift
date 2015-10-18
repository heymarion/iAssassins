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
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let id : NSString = result.valueForKey("id") as! NSString
                print("User id is: \(id)")
                let firstName : NSString = result.valueForKey("first_name") as! NSString
                let lastName : NSString = result.valueForKey("last_name") as! NSString
                print("User first name is: \(firstName)")
                let firstAndLastName =  (firstName as String) + (lastName as String);
                
            }
        })
    }
    
    func
    
}

