//
//  New.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/7/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class News: NSObject {
    var imageUrl:String?
    var title:String?
    var content:String?
    
    override init() {
        super.init()
    }
    
    convenience init(json:SwiftyJSON.JSON){
        self.init()
        self.setUpNews(json)
    }
    
    convenience init(jsonDict:NSDictionary){
        self.init()
        let json = SwiftyJSON.JSON(jsonDict)
        self.setUpNews(json)
    }
    
    init(imageUrl: String, title: String, content: String)  {
        self.imageUrl = imageUrl
        self.title = title
        self.content = content
    }
    
    func setUpNews(_ json:SwiftyJSON.JSON)->() {
        self.imageUrl = json["thumbnailUrl"].string!
        self.title = json["title"].string!
        self.content = json["description"].string!
    }
}

