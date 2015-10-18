//
//  TargetViewController.swift
//  iAssassins
//
//  Created by Marion Xu on 10/17/15.
//  Copyright © 2015 Marion. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class TargetViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var currentGameLabel: UILabel!
    @IBOutlet weak var participantsLeft: UILabel!
    @IBOutlet weak var currTarget: UILabel!
    @IBOutlet weak var targetImage: UIImageView!
    
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "a500248c-abc2-4206-9bd7-034f4fc9ed10")!, identifier: "Beacons")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //current game id loading
        var currGame = currentGameLabel
        var gameId =  //TODO set this to game name frmo current user's game Id
        currGame.text = "Current Game: \(gameId)"
        
        var pL = participantsLeft
        var numPeopleLeft = 3 //TODO set programmatically from db (people left in game)
        pL.text = "Participants remaining: \(numPeopleLeft)"
        
        var curTarg = currTarget
        var target = "Berwin" //TODO set programmatically from db
        curTarg.text = "Current Target: \(target)"
        
        var targPic = targetImage
        targPic.image = UIImage(named: "header_logo") //TODO get image programmatically from DB
        
        
        //TODO do beacon scanning shit every hour and camera
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
        
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        //print(beacons)
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            print(closestBeacon)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}