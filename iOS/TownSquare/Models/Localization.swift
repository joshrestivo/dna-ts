//
//  User.swift
//  PipeFish
//
//  Created by Cuccku on 10/20/14.
//  Copyright (c) 2014 ChangeAbleWorld. All rights reserved.
//

import UIKit
import SwiftyJSON

class LocalizationKey: EVObject {
    
    var key: String?
    var value: NSString?
    
    var values: [LocalizationKey]? = []
}
