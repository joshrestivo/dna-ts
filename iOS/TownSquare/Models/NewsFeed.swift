//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsFeed: NSObject {
    
    var date: String?
    var link: String?
    var title: String?
    
    var feedDescription: String?
    var thumbnail_url: String?
    var thumbnail_width: Float?
    var thumbnail_height: Float?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setNewsFeed(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setNewsFeed(json)
    }
    
    func setNewsFeed(_ json:SwiftyJSON.JSON)->() {
        self.date = json["date"].string!
        self.link = json["link"].string!
        self.title = json["title"].string!
        
        self.feedDescription = json["description"].string!
        self.thumbnail_url = json["thumbnail_url"].string!
        self.thumbnail_width = json["thumbnail_width"].float!
        self.thumbnail_height = json["thumbnail_height"].float!
    }
}
