//
//  Admin2ViewController.swift
//  iAssassins
//
//  Created by Vinh on 10/18/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Admin2ViewController: UIViewController {
    var userLogin : String?
    var userID : String?
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toWaiting"
        {
            let dest = segue.destinationViewController as! WaitingViewController
            dest.userLogin = userLogin
            dest.userID = userID
        }
    }
    
    @IBOutlet weak var startGameButton: UIButton!
    
    
    @IBAction func onClickStart(sender: AnyObject) {
        var ref = Firebase(url: "https://vivid-torch-6580.firebaseio.com/");
        
        //TODO set game to active, assign targets to everyone, yay!
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}