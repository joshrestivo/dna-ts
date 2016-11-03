//
//  MainAppViewController.swift
//  DealARide
//
//  Created by PhucDoan on 8/17/16.
//  Copyright © 2016 PhucDoan. All rights reserved.
//

import Foundation
import CoreLocation

class BaseLocationViewController: BaseViewController {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        initLocationService()
    }
    
    func initLocationService() {
        locationManager = CLLocationManager()
        
        locationManager.startUpdatingLocation()
    }
    
    func updateLocationService() {
        locationManager.stopUpdatingLocation()
        locationManager.startUpdatingLocation()
    }
    
    func stopAllServices() {
        locationManager.stopUpdatingLocation()
    }
}
