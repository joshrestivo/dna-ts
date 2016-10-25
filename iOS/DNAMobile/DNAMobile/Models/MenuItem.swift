//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit

class MenuItem {
    var imageName: String
    var title: String
    var type: MenuItemType!
    
    init(title: String, imageName: String, type: MenuItemType)  {
        self.title = title
        self.imageName = imageName
        self.type = type
    }
}

public enum MenuItemType {
    case leftMenuHome
    case leftMenuUpCommingEvents
    case leftMenuRequestServices
    case leftMenuLocationInfo
    case leftMenuStreetAlert
    case leftMenuSetting    
}
