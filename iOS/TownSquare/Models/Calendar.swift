//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class CalendarModel: NSObject {
    
    var start: Date?
    var end: Date?
    var shorDateString:String?
    
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
        let startInString = json["start"].string
        if startInString != nil {
            start =  startInString?.toLocalDateTime()
        }
        
        let endInString = json["end"].string
        if endInString != nil {
            end =  endInString?.toLocalDateTime()
        }
        
        if startInString != nil && endInString != nil {
            shorDateString = (start?.formattedWith("MM/dd/yyyy - h:mm a"))! + " To " + (end?.formattedWith("MM/dd/yyyy - h:mm a"))!
        }
        else if self.start != nil {
            shorDateString = (start?.formattedWith("MM/dd/yyyy - h:mm a"))!
        }
        else if self.end != nil {
            shorDateString = (end?.formattedWith("MM/dd/yyyy - h:mm a"))!
        }
        
        self.location = json["location"].string
        self.calendarDescription = json["description"].string
    }
}
