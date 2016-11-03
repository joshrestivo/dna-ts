
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

#if DEBUG
    let BASE_HOST = "https://townsquare-dev.herokuapp.com/"
#else
    let BASE_HOST = "https://townsquare-dev.herokuapp.com/"
#endif

let BASE_URL = "\(BASE_HOST)api/1.0/"

class ApiClient {
    var jsonHeaderSession = ["secret-key": "ee9c6aaa512cd328c641d21f13bb2654353d36dc", "content-type": "application/json", "cache-control": "no-cache"]
    
    class var sharedInstance : ApiClient {
        struct Static {
            static let instance : ApiClient = ApiClient()
        }
        return Static.instance
    }
    
    func  getAbsoluteUrl(_ relativeUrl: String) -> String{
        return BASE_URL + relativeUrl;
    }
    
    func executeRequest(_ url: String, _ method: HTTPMethod, _ params: Parameters? = nil, callback: @escaping (AnyObject?,Bool) -> ()) {
        request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: jsonHeaderSession).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success(let aData):
                if let stringData = aData as? String{
                    let dataResponse: Data = stringData.data(using: String.Encoding.utf8)!
                    self.handleDataCommond(dataResponse: dataResponse, url: url, callBack: callback)
                }else if let unwrappedData = aData as? NSDictionary {
                    if let successAuthent = unwrappedData["success"] as? Bool{
                        let dataDict = unwrappedData["data"] as Any
                        callback(dataDict as AnyObject?, successAuthent)
                    }else{
                        
                        callback(nil, false)
                    }
                    
                }else if let dataResponse = aData as? Data{
                    self.handleDataCommond(dataResponse: dataResponse, url: url, callBack: callback)
                }else{
                    
                    callback(nil, false)
                }
                break
                
            case .failure(let error):
                callback(nil, false)
                break
            }
        }
    }
    
    func handleDataCommond (dataResponse: Data, url:String?, callBack:(AnyObject?, Bool)->())->(){
        var errorParse:NSError?
        let json: AnyObject?
        do
        {
            json = try JSONSerialization.jsonObject(with: dataResponse, options: JSONSerialization.ReadingOptions.allowFragments) as? AnyObject
        }
        catch let error as NSError
        {
            errorParse = error
            json = nil
        }
        
        if let unwrappedData = json as? NSDictionary {
            if let successAuthent = unwrappedData["success"] as? Bool{
                let dataDict = unwrappedData["data"] as AnyObject
                callBack(dataDict, successAuthent)
            }else{
                callBack(nil, false)
            }
            
        }else{
            callBack(nil, false)
        }
    }
}
