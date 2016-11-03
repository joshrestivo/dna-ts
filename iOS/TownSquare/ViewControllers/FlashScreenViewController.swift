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
    
    //var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        self.showLoading("")
        //initLocationService()
        //test()
        authentication()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLocationService() {
        //locationManager = CLLocationManager()
        //locationManager.pausesLocationUpdatesAutomatically = false
        //locationManager.distanceFilter = kCLDistanceFilterNone
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.activityType = .automotiveNavigation
        //locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
    }
    
    func test(){
        ApiService.ping( { (isSuccess) in
            if (isSuccess != nil) {
                self.hideLoading()
                            }
            else{
                self.hideLoading()
            }
        })

    }
    
    func authentication(){
        //let longitude = String(describing: locationManager.location?.coordinate.longitude)
        //let latitude = String(describing: locationManager.location?.coordinate.latitude)
        
        let longitude = "-122.406417"
        let latitude = "37.785834000000001"
        
        ApiService.authenticate(longitude: longitude,latitude: latitude, { (location, isSuccess) in
            if isSuccess {
                self.hideLoading()
                let secondViewController = self.sbMain.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            else{
                self.hideLoading()
            }
        })
    }
}
