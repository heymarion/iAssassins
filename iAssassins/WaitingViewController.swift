//
//  WaitingViewController.swift
//  iAssassins
//
//  Created by Vinh on 10/18/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import Foundation
import UIKit

class WaitingViewController: UIViewController {
    //@IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("waiting")
    }
    
    override func viewDidAppear(animated: Bool) {
        let gameactive = true
        super.viewDidAppear(animated)
        
        if (gameactive) { //TODO change to check if theres an acive game - if so start. else wait. maybe while (!game is active)?
            performSegueWithIdentifier("toStartGame", sender: nil)
        }
        
    }
    
    /*
    @IBAction func onClickStart(sender: AnyObject) {
        
        //TODO set game from inactive to active, set everyone to alive, assign targets to everyone, starting game stuff
        
        
        performSegueWithIdentifier("toStartGame", sender: nil)
    }
*/
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}