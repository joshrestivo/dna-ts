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

class FlashScreenViewController: BaseViewController,CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        self.showLoading("")
        initLocationService()
        locationManager.delegate = self
        locationManager.distanceFilter = 20
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
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.activityType = .automotiveNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func authentication(){
        var longitude = locationManager.location?.coordinate.longitude.description
        var latitude = locationManager.location?.coordinate.latitude.description
        if longitude == nil {
            longitude = "10"
        }
        if latitude == nil {
            latitude = "10"
        }
        
        ApiService.authenticate(longitude: longitude,latitude: latitude, { (location, isSuccess) in
            if isSuccess {
                self.saveResourceValues(location: location)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setMainVC()
            }
            else{
                self.hideLoading()
            }
        })
    }
    
    func saveResourceValues(location:LocationInfo){
        var locationId = NSString(string: (location.id?.description)!)
        ConstantHelper.cache.setObject(locationId, forKey: "location_id", expires: .never)
        let resourceDetails = location.client_resource?.details
        ConstantHelper.setCacheValues(resourceDetails!)
    }
}
