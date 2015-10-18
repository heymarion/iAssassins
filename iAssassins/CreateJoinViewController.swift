//
//  CreateJoinViewController.swift
//  iAssassins
//
//  Created by Marion Xu on 10/17/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateJoinViewController: UIViewController {
    
    //@IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var joinSubmit: UIButton!
    @IBOutlet weak var createSubmit: UIButton!
    
    @IBOutlet weak var joinId: UITextField!
    @IBOutlet weak var createId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var ref = Firebase(url: "https://vivid-torch-6580.firebaseio.com/");
    
    
    
    @IBAction func onCreateSubmit(sender: AnyObject) {
        if let name = createId.text {
            if (!name.isEmpty) { //change to check if name isn't taken yet
                //TODO create game & set current user to admin
                if(ref.queryOrderedByChild("gameid").queryEqualToValue(name) != nil)
                {
                    performSegueWithIdentifier("toAdmin", sender: nil)
                }
            }
            else {
                //id already taken try again
            }
        }
        else {
            //pls enter a name        
        }
    }
    
    @IBAction func onJoinSubmit(sender: AnyObject) {
        if let name = joinId.text {
            if (!name.isEmpty) { //change to check if name is taken
                //TODO join game (add current user to game)
                performSegueWithIdentifier("toWaiting", sender: nil)
            }
            else {
                //game id doesnt exist - cant join
            }
        }
        else {
            //pls enter a name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}