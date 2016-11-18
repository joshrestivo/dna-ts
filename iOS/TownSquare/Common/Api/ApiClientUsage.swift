
import Foundation
import Alamofire
import SwiftyJSON
import NoOptionalInterpolation

enum RestUrl: String {
    var value: String {
        return self.rawValue
    }
    
    ///////////////////////////////////////////////////////
    /// Api Rest string parameters
    ///////////////////////////////////////////////////////
    case postPing = "ping"
    case postUserAuth = "auth"
    case getBulletins = "main/%@/bulletins?page=%d&limit=%d"
    case getBuilding = "main/%@/buildings?page=%d&limit=%d"
    case getLocations = "locations?page=%d&limit=%d"
    case getLocationResource = "location/%d"
    case getStreetAlerts = "main/%@/street-alerts"
    case getUpcomingEvents = "main/%@/news?page=%d&limit=%d"
    case getCalendar = "main/%@/calendar"
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
                callback("")
            }else{
                callback("")
            }
        }
    }
    
    func authenticate(longitude: String?, latitude: String?, _ callback: @escaping (LocationInfo, Bool) -> ()) {
        let url = self.Api.getAbsoluteUrl(RestUrl.postUserAuth.value)
        let params: Parameters = [
            "longitude" : longitude! as String,
            "latitude" : latitude! as String,
            "client_os" : "IOS",
            "device_token" : "Test"
        ]
        
        Api.executeRequest(url, .post, params) { (resObject, isSuccess) in
            if(isSuccess == true){
                if let dataUser = resObject as? Dictionary<String, AnyObject> {
                    let json = JSON(dataUser)                    
                    let location = LocationInfo(json: json)
                    callback(location, true)
                }
                else{
                    callback(LocationInfo(), false)
                }
            }
            else{
                callback(LocationInfo(), false)
            }
        }
    }
    
    func getBulletins( pageIndex: Int?,  _ callback: @escaping ([Bulletins], Bool) -> ()) {
        let locationId:String! = String(ConstantHelper.cache["location_id"]!.description)
        let urlFormat = NSString(format: RestUrl.getBulletins.value as NSString, locationId,pageIndex! ,ConstantHelper.defaultPageSize) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)
        var bulletins = [Bulletins]()
        
        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                
                if let unwrappedData = resObject as? [NSDictionary] {
                    for jsonData in unwrappedData{
                        let json = SwiftyJSON.JSON(jsonData)
                        bulletins.append( Bulletins(json: json))
                    }
                    
                    callback(bulletins, true)
                }else{
                    callback(bulletins, false)
                }
            }
            else{
                callback(bulletins, false)
            }
        }
    }
    
    func getBuildings(pageIndex: Int?, _ callback: @escaping ([Building], Bool) -> ()) {
        let locationId = ConstantHelper.cache["location_id"] as! String
        
        let urlFormat = NSString(format: RestUrl.getBuilding.value as NSString, locationId,pageIndex!, ConstantHelper.defaultPageSize ) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)
        var buildings = [Building]()
        
        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                
                if let unwrappedData = resObject as? [NSDictionary] {
                    for jsonData in unwrappedData{
                        let json = SwiftyJSON.JSON(jsonData)
                        buildings.append( Building(json: json))
                    }
                    
                    callback(buildings, true)
                }else{
                    callback(buildings, false)
                }
            }
            else{
                callback(buildings, false)
            }
        }
    }
    
    func getLocations(pageIndex: Int?, _ callback: @escaping ([LocationInfo], Bool) -> ()) {
        let urlFormat = NSString(format: RestUrl.getLocations.value as NSString, pageIndex!, ConstantHelper.defaultPageSize ) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)
        var locations = [LocationInfo]()
        
        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                
                if let unwrappedData = resObject as? [NSDictionary] {
                    for jsonData in unwrappedData{
                        let json = SwiftyJSON.JSON(jsonData)
                        locations.append( LocationInfo(json: json))
                    }
                    
                    callback(locations, true)
                }else{
                    callback(locations, false)
                }
            }
            else{
                callback(locations, false)
            }
        }
    }

    func getLocation(id: Int?, _ callback: @escaping (LocationInfo, Bool) -> ()) {
        let urlFormat = NSString(format: RestUrl.getLocationResource.value as NSString, id!) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)
        
        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                if let unwrappedData = resObject as? Dictionary<String, AnyObject>  {
                    let json = SwiftyJSON.JSON(unwrappedData)
                    let location = LocationInfo(json: json)
                    callback(location, true)
                }else{
                    callback(LocationInfo(), false)
                }
            }
            else{
                callback(LocationInfo(), false)
            }
        }
    }
    
    func getStreetAlerts(_ callback: @escaping ([StreetAlert]? , Bool) -> ()) {
        let locationId = ConstantHelper.cache["location_id"] as! String

        let urlFormat = NSString(format: RestUrl.getStreetAlerts.value as NSString, locationId) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)

        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                var streetAlerts = [StreetAlert]()

                if let unwrappedData = resObject as? [NSDictionary] {
                    for jsonData in unwrappedData{
                        let json = SwiftyJSON.JSON(jsonData)
                        streetAlerts.append(StreetAlert(json: json))
                    }
                    
                    callback(streetAlerts, true)
                }else{
                    callback(streetAlerts, false)
                }
            }
            else{
                callback(nil, false)
            }
        }
    }
    
    func getNewsFeeds(pageIndex: Int?, _ callback: @escaping ([NewsFeed] , Bool) -> ()) {
        let locationId:String! = String(ConstantHelper.cache["location_id"]!.description)
        let urlFormat = NSString(format: RestUrl.getUpcomingEvents.value as NSString, locationId, pageIndex!, ConstantHelper.defaultPageSize) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)
        var newsFeeds = [NewsFeed]()
        
        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                if let unwrappedData = resObject as? [NSDictionary] {
                    for jsonData in unwrappedData{
                        let json = SwiftyJSON.JSON(jsonData)
                        newsFeeds.append(NewsFeed(json: json))
                    }
                    
                    callback(newsFeeds, true)
                }else{
                    callback(newsFeeds, false)
                }
            }
            else{
                callback(newsFeeds, false)
            }
        }
    }
    
    func getCalendars(_ callback: @escaping ([CalendarModel] , Bool) -> ()) {
        let locationId:String! = String(ConstantHelper.cache["location_id"]!.description)
        let urlFormat = NSString(format: RestUrl.getCalendar.value as NSString, locationId) as String
        let url = self.Api.getAbsoluteUrl(urlFormat)
        var calendars = [CalendarModel]()
        
        Api.executeRequest(url, .get, nil) { (resObject, isSuccess) in
            if(isSuccess == true){
                if let unwrappedData = resObject as? [NSDictionary] {
                    for jsonData in unwrappedData{
                        let json = SwiftyJSON.JSON(jsonData)
                        calendars.append(CalendarModel(json: json))
                    }
                    
                    callback(calendars, true)
                }else{
                    callback(calendars, false)
                }
            }
            else{
                callback(calendars, false)
            }
        }
    }
}
