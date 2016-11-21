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
    
    var date_data: Date?
    var date_in_string: String?
    var link: String?
    var thumbnailUrl: String?
    
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
   
    init(title: String, description: String)  {
        self.date_data = title.toLocalDateTime()
        self.date_in_string = self.date_data?.formattedWith("MM/dd/yyyy - h:mm a")
        self.link = description
        self.thumbnailUrl = ""
    }
    
    func setStreetAlert(_ json:SwiftyJSON.JSON)->() {
        let originalDate = json["date"].string!
        
        self.date_data = originalDate.toLocalDateTime()
        self.date_in_string = self.date_data?.formattedWith("MM/dd/yyyy - h:mm a")
        self.link = json["link"].string
        self.thumbnailUrl = ""
    }
}
