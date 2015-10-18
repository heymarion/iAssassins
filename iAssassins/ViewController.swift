//
//  ViewController.swift
//  iAssassins
//
//  Created by Marion Xu on 10/17/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import UIKit
import Firebase
class LLNode<T> {
    var key: T?;
    var next: LLNode?;
}

public class LinkedList<T: Equatable> {
    
    //create a new LLNode instance
    private var head: LLNode<T> = LLNode<T>();
    
    //append a new item to a linked list
    func addLink(key: T) {
        //establish the head node
        if (head.key == nil) {
            head.key = key;
            head.next = head;
            return;
        }
        
        var current: LLNode? = head;
        
        while (current != nil) {
            if (current?.next == head) {
                var childToUse: LLNode = LLNode<T>();
                childToUse.key = key;
                childToUse.next = head;
                current!.next = childToUse;
                break;
            }
            
            current = current?.next;
        }
    }
    
    func removeLinkAtIndex(index: Int) {
        var current: LLNode<T>? = head;
        var trailer: LLNode<T>?;
        var listIndex: Int = 0;
        
        //determine if the removal is at the head
        if (index == 0) {
            current = current?.next;
            head = current!;
            return;
        }
        
        while (current != nil) {
            if (listIndex == index) {
                
                trailer!.next = current?.next;
                current = nil; break;
            }
            
            //update the assignments
            trailer = current;
            current = current?.next;
            listIndex++;
        }
    }
}
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
    var firstAndLastName : String?
    var id : String?
    
    func returnUserData() -> Dictionary<String, AnyObject>
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
                self.id = result.valueForKey("id") as! NSString as String
                print("User id is: \(self.id)")
                let firstName : NSString = result.valueForKey("first_name") as! NSString
                let lastName : NSString = result.valueForKey("last_name") as! NSString
                print("User first name is: \(firstName)")
                self.firstAndLastName =  (firstName as String) + (lastName as String);
                let photoURL = "http://graph.facebook.com/"+(self.id)!+"/picture"
                self.addUser(id!, name: firstAndLastName!, photo: photoURL, dead: false, targid: "")
            }
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue1"
        {
            let dest = segue.destinationViewController as! CreateJoinViewController
            dest.userLogin = firstAndLastName
            dest.userID = id
        }
    }
    // returns pointer to linkedList
    func makeGame(gameid: String, uid: NSString) -> LinkedList<String> {
        var ref =  Firebase(url: "https://vivid-torch-6580.firebaseio.com/");
        var gameRef = ref.childByAppendingPath("Games");
        var usersRef = ref.childByAppendingPath("Users")
        var gameObj = ["gameid": gameid,
            "active": false,
        ];
        var userObj = ["admin":1]
        usersRef.childByAppendingPath(uid as String).updateChildValues(userObj)
        gameRef.childByAppendingPath(gameid as String).setValue(gameObj)
        var list = LinkedList() as LinkedList<String>;
        usersRef.queryOrderedByChild("gameid").queryEqualToValue(gameid)
            .observeEventType(.ChildAdded, withBlock: { snapshot in
                
                list.addLink(snapshot.value);
            })
        return list
    }
    
    func addUser(uid: NSString,name: NSString, photo: String, dead: Bool, targid: String) -> Bool {
            var ref = Firebase(url: "https://vivid-torch-6580.firebaseio.com/");
            var usersRef = ref.childByAppendingPath("Users");
            var userObj = ["uid": uid,
                "name": name,
                "photo": photo,
                "dead": false,
                "targid": targid,
                "admin":false
        ];
        usersRef.childByAppendingPath(uid as String).setValue(userObj)
    }
    /*
    func joinGame(uid: NSString,
        gameid: String) {
            var ref = new1 Firebase("https://vivid-torch-6580.firebaseio.com/");
            usersRef = ref.childByAppendingPath("Users");
            var userObj = ["gameid": gameid,
                "status": 1]
            usersRef.child(uid).update(userObj)
    }
    */
    
}

