//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class StreetAlert: NSObject {
    
    var thumbnailUrl: String?
    var txtTitle: String?
    var txtDescription: String?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setStreetAlert(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setStreetAlert(json)
    }
   
    init(thumbnailUrl: String, title: String, description: String)  {
        self.thumbnailUrl = thumbnailUrl
        self.txtTitle = title
        self.txtDescription = description
    }
    
    func setStreetAlert(_ json:SwiftyJSON.JSON)->() {
//        self.thumbnailUrl = json["thumbnailUrl"].string!
        self.txtTitle = json["date"].string!
        self.txtDescription = json["link"].string!
    }
}
