//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class Calendar: NSObject {
    
    var start: String?
    var end: String?
    var location: String?
    var calendarDescription: String?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setCalendar(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setCalendar(json)
    }
    
    func setCalendar(_ json:SwiftyJSON.JSON)->() {
        self.start = json["id"].string
        self.end = json["end"].string
        self.location = json["location"].string
        self.calendarDescription = json["description"].string
    }
}
