
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
    case postUserAuth = "auth"
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
        Api.executeRequest(url, .get) { (resObject, isSuccess) in
            if(isSuccess == true){
                let validData = resObject as! NSDictionary
                let json = JSON(validData)                
                ConstantHelper.cache.setObject("", forKey: ConstantHelper.localizationKey, expires: .never)
            }else{
                callback("")
            }
        }
    }
    
    func authenticate(longitude: String?, latitude: String?, _ callback: @escaping (LocationInfo, Bool) -> ()) {
        let url = self.Api.getAbsoluteUrl(RestUrl.postUserAuth.value)
        let params: Parameters = [
            "longitude" : longitude,
            "latitude" : latitude,
            "client_os" : "IOS",
            "device_token" : "Test"
        ]
        
        Api.executeRequest(url, .post, params) { (resObject, isSuccess) in
            if(isSuccess == true){
                let dataUser = resObject as! NSDictionary
                let json = JSON(dataUser)
                let location = LocationInfo(json: json)
                callback(location, true)
            }
            else{
                callback(LocationInfo(), false)
            }
        }
    }
    
    func getLocalazation(_ latitude:String, longitude:String, callback: @escaping (String,Bool, ErrorCodeParam) -> ()){
        let url = self.Api.getAbsoluteUrl(RestUrl.getLocalazation.value)
        
        let params: Parameters = ["latitude" : latitude,"longitude" : longitude]
        Api.executeRequest(url, .post, params) { (resObject, isSuccess) in
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
