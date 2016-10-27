//
//  ApiClient.swift
//  DealARide
//
//  Created by PhucDoan on 8/30/15.
//  Copyright (c) 2015 PhucDoan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

#if DEBUG
    let BASE_HOST = "http://hovit-dev.azurewebsites.net"
    let SignalRURL = "http://devsignalr.hovit.com/"
#else
    let BASE_HOST = "https://api.hovit.com"
    let SignalRURL = "https://channel.hovit.com"
#endif

let BASE_URL = "\(BASE_HOST)/api/"

class ApiClient {
    var jsonHeaderSession = [
        "Content-Type": "application/json",
        "Accept": "application/vnd.lichess.v1+json",
        "User-Agent": "007"
    ]
    
    class var sharedInstance : ApiClient {
        struct Static {
            static let instance : ApiClient = ApiClient()
        }
        return Static.instance
    }
    
    func  getAbsoluteUrl(_ relativeUrl: String) -> String{
        return BASE_URL + relativeUrl;
    }

    func executeRequest(_ url: String, _ method: HTTPMethod, _ params: Parameters? = nil, callback: @escaping (Bool, AnyObject?) -> ()) {
        request(url, method: method, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            let result = response.result
            if result.isSuccess {
                let resultData = result.value as! NSDictionary
                self.handleResponseWithData(resultData, callBack: { (dataResponse, isSuccess) in
                    callback(isSuccess, dataResponse)
                })
            }else {
                callback(false, nil)
            }
        }
    }
    
    func handleResponseWithData(_ aData: NSDictionary, callBack: @escaping (AnyObject?, Bool) -> ()) {
        if let unwrappedData = aData as? Dictionary<String, AnyObject> {
            if let successAuthent = unwrappedData["Success"] as? Bool{
                callBack(unwrappedData["Data"], successAuthent)
            }else{
                callBack(nil, false)
            }
        }
    }
}
