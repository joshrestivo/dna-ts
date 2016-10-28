//
//  ApiClientUsage.swift
//  DealARide
//
//  Created by PhucDoan on 8/30/15.
//  Copyright (c) 2015 PhucDoan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum RestUrl: String {
    var value: String {
        return self.rawValue
    }
    
    ///////////////////////////////////////////////////////
    /// Api Rest string parameters
    ///////////////////////////////////////////////////////
    case postPing = "ping"
    case getLocalazation = "getLocalazation"
    // Client log
    case commonLogs = "common/logs"
}

class ApiClientUsage {
    
    var errorHelper: ErrorTypeHelper = ErrorTypeHelper()
    var noErrorParam = ErrorCodeParam(code: ErrorType.NONE, extParam: "", message: "")
    var unknownErrorParam = ErrorCodeParam(code: ErrorType.UNKNOWN, extParam: "", message: "")
    var Api: ApiClient! = ApiClient.sharedInstance
    
    class var shareInstance : ApiClientUsage {
        struct Static {
            static let instance : ApiClientUsage = ApiClientUsage()
        }
        
        return Static.instance
    }
    
    func getTokenDeviceString() -> String {
        let tokenDevice = UserDefaults.standard.object(forKey: "device_token") as! String!
        if tokenDevice != nil && tokenDevice?.isEmpty == false{
            return tokenDevice!
        }else {
            return ""
        }
    }
    
    ///////////////////////////////////////////////////////
    /// Api executing
    ///////////////////////////////////////////////////////
    func ping(_ callback:@escaping (String?) -> ()) {
        let url = self.Api.getAbsoluteUrl(RestUrl.postPing.value)
        Api.executeRequest(url, .post) { (isSuccess, resObject) in
            if(isSuccess == true){
                let validData = resObject as! NSDictionary
                let json = JSON(validData)                
                ConstantHelper.cache.setObject("", forKey: ConstantHelper.localizationKey, expires: .never)
            }else{
                callback("")
            }
        }
    }
    
    func getLocalazation(_ latitude:String, longitude:String, callback: @escaping (String,Bool, ErrorCodeParam) -> ()){
        let url = self.Api.getAbsoluteUrl(RestUrl.getLocalazation.value)
        
        let params: Parameters = [
            "latitude" : latitude,
            "longitude" : longitude
        ]
        
        Api.executeRequest(url, .post, params) { (isSuccess, resObject) in
            if(isSuccess == true){
                let jsonData = resObject as! String
                callback(jsonData,true, self.noErrorParam)
            }else{
                if(resObject != nil) {
                    let errorData = resObject as! String
                    let objError = self.errorHelper.getErrorCodeFromString(errorData)
                    callback("",false, objError)
                }else {
                    callback("",false, self.unknownErrorParam)
                }
            }
        }
    }
    
}
