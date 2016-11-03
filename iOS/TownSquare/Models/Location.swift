//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class LocationInfo: NSObject {
    
    var id: String?
    var longitude: String?
    var latitude: String?
    var name: String?
    
    var city: String?
    var state: String?
    var country_code: String?
    var country: String?
    var has_upcomming_events: Bool?
    
    var has_request_service: Bool?
    var has_location_info: Bool?
    var has_street_alerts: Bool?
    
    var created_by: String?
    var updated_by: String?
    
    var created_at: String?
    var updated_at: String?
    var client_resource: ClientResource?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setLocation(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setLocation(json)
    }
    
    func setLocation(_ json:SwiftyJSON.JSON)->() {
        self.id = json["id"].string!
        self.longitude = json["longitude"].string!
        self.latitude = json["latitude"].string!
        
        self.name = json["name"].string!
        self.city = json["city"].string!
        
        self.state = json["state"].string!
        self.country_code = json["country_code"].string!
        self.country = json["country"].string!
        
        self.has_upcomming_events = json["has_upcomming_events"].bool!
        self.has_request_service = json["has_request_service"].bool!
        self.has_location_info = json["has_location_info"].bool!
        self.has_street_alerts = json["has_street_alerts"].bool!
        
        self.created_by = json["created_by"].string!
        self.updated_by = json["updated_by"].string!
        self.created_at = json["created_at"].string!
        self.updated_at = json["updated_at"].string!
        
        if let resource = json["client_resource"].dictionary{
            client_resource = ClientResource(jsonDict: resource as NSDictionary)
        }
    }
}

class ClientResource: NSObject {
    
    var id: String?
    var name: String?
    var is_default: Bool?
    
    var created_by: String?
    var updated_by: String?
    
    var created_at: String?
    var updated_at: String?
    
    var details = [ClientResourceDetail]()
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setClientResource(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setClientResource(json)
    }
    
    func setClientResource(_ json:SwiftyJSON.JSON)->() {
        self.id = json["id"].string!
        self.name = json["name"].string!
        self.created_by = json["created_by"].string!
        self.updated_by = json["updated_by"].string!
        self.created_at = json["created_at"].string!
        self.updated_at = json["updated_at"].string!
        
        if let clientResources = json["details"].array{
            for clientResource in clientResources {
                if let resource = clientResource as? NSDictionary{
                    let resourceItem = ClientResourceDetail(jsonDict: resource)
                    details.append(resourceItem)
                }
            }
        }
    }
}

class ClientResourceDetail: NSObject {
    
    var unique_name: String?
    var display_text: String?
    
    var created_by: String?
    var updated_by: String?
    
    var created_at: String?
    var updated_at: String?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setResourceDetail(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setResourceDetail(json)
    }
    
    func setResourceDetail(_ json:SwiftyJSON.JSON)->() {
        self.unique_name = json["unique_name"].string!
        self.display_text = json["display_text"].string!
        self.created_by = json["created_by"].string!
        self.updated_by = json["updated_by"].string!
        self.created_at = json["created_at"].string!
        self.updated_at = json["updated_at"].string!
    }
}
