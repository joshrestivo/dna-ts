//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class Building: NSObject {
    
    var id: Int?
    var location_id: Int?
    var name: String?
    var address: String?
    var zipcode: String?
    
    var image_url: String?
    var image_width: String?
    var image_height: String?
    
    var thumbnail_url: String?
    var thumbnail_width: String?
    var thumbnail_height: String?
    
    var created_by: String?
    var updated_by: String?
    var created_at: String?
    var updated_at: String?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setBuilding(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setBuilding(json)
    }
    
    func setBuilding(_ json:SwiftyJSON.JSON)->() {
        self.id = json["id"].int!
        self.location_id = json["location_id"].int!
        self.name = json["name"].string!
        
        self.address = json["address"].string!
        self.zipcode = json["zipcode"].string!
        
        self.image_url = json["image_url"].string!
        self.image_width = json["image_width"].string!
        self.image_height = json["image_height"].string!
        
        self.thumbnail_url = json["thumbnail_url"].string!
        self.thumbnail_width = json["thumbnail_width"].string!
        self.thumbnail_height = json["thumbnail_height"].string!
        
        self.created_by = json["created_by"].string!
        self.updated_by = json["updated_by"].string!
        self.created_at = json["created_at"].string!
        self.updated_at = json["updated_at"].string!
    }
}
