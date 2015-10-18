//
//  Admin2ViewController.swift
//  iAssassins
//
//  Created by Vinh on 10/18/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import Foundation
import UIKit

class Admin2ViewController: UIViewController {
    
    
    @IBOutlet weak var startGameButton: UIButton!
    
    
    @IBAction func onClickStart(sender: AnyObject) {
        //TODO set game to active, assign targets to everyone, yay!
        returnUserData()
        
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