//
//  ViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/4/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation

class FlashScreenViewController: BaseViewController {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        self.showLoading("")
        initLocationService()
        authentication()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLocationService() {
        locationManager = CLLocationManager()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func authentication(){
        let longitude = locationManager.location?.coordinate.longitude.description
        let latitude = locationManager.location?.coordinate.latitude.description
        ApiService.authenticate(longitude: longitude,latitude: latitude, { (location, isSuccess) in
            if isSuccess {
                self.hideLoading()
                self.navigateToView("HomeViewControllerID")
                /*
                let secondViewController = self.sbMain.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
                */
            }
            else{
                self.hideLoading()
            }
        })
    }
}
