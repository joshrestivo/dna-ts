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
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLocationService() {
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        checkStatusLocation()
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
    
    func checkStatusLocation(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            
            authentication()
            break
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse, .restricted, .denied:
            let alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}

extension FlashScreenViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkStatusLocation()
    }
    
}
