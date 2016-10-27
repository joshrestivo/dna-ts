//
//  ErrorMessageControl.swift
//  DealARide
//
//  Created by PhucDoan on 10/14/15.
//  Copyright © 2015 PhucDoan. All rights reserved.
//

import Foundation

enum ErrorType: String {
    
    case TEST = "TEST"
    case UNKNOWN = "UNKNOWN"
    case NONE = "NONE"
    
    var value: String {
        return self.rawValue
    }
}

class ErrorMessage {
    static func getErrorDetail(_ error: ErrorType) -> (title: String, msg: String) {
        
        let sTitle: String = ""
        var sMessage: String = ""
        
        switch error {
            case ErrorType.TEST:
                sMessage = "Test message"
            default: break
        }
        
        return (sTitle,sMessage)
    }
}
