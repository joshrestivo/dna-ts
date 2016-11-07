//
//  ConstantPipeFish.swift
//  PipeFish
//
//  Created by Cuc Nguyen on 11/20/14.
//  Copyright (c) 2014 CloudZilla. All rights reserved.
//

import Foundation
import SDWebImage

struct ConstantHelper {
    
    static var redColor = UIColor(red: 211 / 255.0, green: 55 / 255.0, blue: 42 / 255.0, alpha: 1)
    
    static var borderColor = UIColor(red: 236 / 255.0, green: 236 / 255.0, blue: 236 / 255.0, alpha: 1)
    
    static var buttonBorderColor = UIColor(red: 144 / 255.0, green: 31 / 255.0, blue: 24 / 255.0, alpha: 1)
    
    static var defaultTextColor = UIColor(red: 50.0/255.0, green: 128.0/255.0, blue: 202.0/255, alpha: 1)
    
    static var whiteColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    static var blackColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    static var activedTextColor = UIColor(red: 127/255.0, green: 127/255.0, blue: 127/255, alpha: 1)
    
    //Table color
    
    static var headerSessionColor = UIColor(red: 231/255, green: 232/255, blue: 232/255, alpha: 1.0)
    
    static var defaultSessionBgColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255, alpha: 1)
    
    static var defaultSessionTextColor = UIColor(red: 120/255, green: 120/255, blue: 121/255, alpha: 1.0)
    
    //Twitter info
    
    static var TWITTER_CONSUMER_KEY = "FE5lvbrybLMQZZxPAvSQ";
    
    static var TWITTER_CONSUMER_SECRET = "wCu7dJLmc2LXOuVYpImp0HjcPZqIP6OxJBxmfQlirNc";
    
    static var imgAvatarNotFound = "avatar-not-found.jpeg"
    
    static var imgNotFound = "icon-notFound.jpeg"

    static var defaultPageSize = 15;

    static var userUuid = UUID().uuidString;
    
    static var intervalTimeForNotification:TimeInterval = Double(30)

    static var defaultFontName = "Lato-Regular"
    
    static var navFontSize:CGFloat = 16
    
    static var placeholderColor = UIColor(red: 109/255, green: 109/255, blue: 109/255, alpha: 1.0)

    static let attributedAlertString = NSAttributedString(string: "", attributes: [NSFontAttributeName : UIFont(name: defaultFontName, size: 14)! ,NSForegroundColorAttributeName : UIColor.red])
    
    static let cache = try! Cache<NSString>(name: "cacheLocalization")
    
    static let localizationKey = "localizationCacheKey"
    
    static var languageKeys = [LocalizationKey]()
    
    static func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
    }
    
    static func isImagePath(_ path:String) ->Bool{
        if (path.lowercased().range(of: ".png") != nil || path.lowercased().range(of: ".jpg") != nil || path.lowercased().range(of: ".jpeg") != nil) {
            return true
        }
        
        return false
    }
    
    static func ConvertToImagePath(_ path: String?, hasThumnail:Bool) -> String{
        if(path == ""){
            return path!
        }
        else{
            
            if(!isImagePath(path!)){
                return ""
            }
            
            if path!.hasPrefix("https://s3"){
                let S3_UPLOAD_URL: String = "https://s3.amazonaws.com/pipefish-barrier/uploads/"
                let externalDomain: String = "://"
                var newImage:String
                
                if (path!.range(of: externalDomain) != nil) {
                    var imageSegments = path!.components(separatedBy: "/")
                    let imageFileName = imageSegments[imageSegments.count - 1]
                    
                    if(hasThumnail){
                        newImage = "100x100_" + imageFileName
                    }
                    else{
                        newImage =  "400x400_" + imageFileName
                    }
                    
                    let resizedImagePath = path!.replacingOccurrences(of: imageFileName, with: newImage, options: NSString.CompareOptions.literal, range: nil)
                    return resizedImagePath
                }
                else{
                    if(hasThumnail){
                        
                        newImage = S3_UPLOAD_URL + "100x100_" + path!
                    }
                    else{
                        newImage = S3_UPLOAD_URL + path!
                    }
                    
                    return newImage
                }
            }
        }
        return path!
    }
    
    static func addAsyncImage(_ image: AsyncImageView, imageUrl:String?, imgNotFound: String?){
        if(imageUrl != "" && imageUrl != nil){
            AsyncImageLoader.shared().cancelLoadingImages(forTarget: imageUrl)
            if let urlImage = URL(string: imageUrl!){
                image.sd_setImage(with: urlImage, placeholderImage: UIImage(named: imgNotFound!), options: SDWebImageOptions.continueInBackground)
            }
            else{
                image.image = UIImage(named:imgNotFound!)
            }
        }
        else{
            image.image = UIImage(named: imgNotFound!)
        }
    }
    
    static func addImage(_ image: UIImageView, imageUrl:String?, imgNotFound: String?){
        if(imageUrl != "" && imageUrl != nil){
            AsyncImageLoader.shared().cancelLoadingImages(forTarget: imageUrl)
            if let urlImage = URL(string: imageUrl!){
                image.sd_setImage(with: urlImage, placeholderImage: UIImage(named: imgNotFound!), options: SDWebImageOptions.continueInBackground)
            }
            else{
                image.image = UIImage(named:imgNotFound!)
            }
        }
        else{
            image.image = UIImage(named: imgNotFound!)
        }
    }
    
    static func roundImageWithColor(_ image: UIImageView, color: UIColor, borderWidth: Float){
        image.layer.borderColor = color.cgColor
        image.layer.borderWidth = CGFloat(borderWidth)
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
    
    static func roundButton(_ target: UIButton, color: UIColor?, radius: CGFloat){
        target.layer.cornerRadius = radius
        target.layer.borderWidth = 1
        target.layer.borderColor = color?.cgColor        
    }
    
    static func getUserFont () -> String? {
        let defaultFontName = "Lato.ttf"
        return UserDefaults.standard.object(forKey: defaultFontName) as? String
    }
    
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    static func stringFromTimeInterval(_ interval:TimeInterval) -> NSString {
        
        let ti = NSInteger(interval)        
        
        let seconds = ti
        let minutes = (ti / 60)
        let hours = (ti / 60) % 60
        
        if(hours > 0){
            return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        }
        else if(minutes > 0){
            return NSString(format: "%0.2d:%0.2d",minutes,seconds)
        }
        else if(seconds > 0){
            return NSString(format: "%0.2d:%0.2d",minutes,seconds)
        }
        else{
            return ""
        }
    }
    
    static func applySearchBarColor(searchBars: UISearchBar?, color: UIColor?){
        if searchBars != nil {
            for subView in (searchBars?.subviews)!  {
                for subsubView in subView.subviews  {
                    if let textField = subsubView as? UITextField {
                        textField.textColor = color
                    }
                }
            }
        }
    }
    
    static func roundBorderViewName(_ target: UIView){
        target.layer.cornerRadius = 10.0
        target.clipsToBounds = true
    }
    
    static func changeLastTextColor(_ text: String, target:UILabel){
        var mutableText = NSMutableAttributedString()
        mutableText = NSMutableAttributedString(string: text, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15)])
        mutableText.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location: text.characters.count - 1,length: 1))
        target.attributedText = mutableText
    }
    
    static func existInCache(_ newCache: [LocalizationKey])->Bool?{
        for item in newCache {
            if ConstantHelper.localizationKey == item.key && ConstantHelper.cache[ConstantHelper.localizationKey] == item.value {
                return true
            }
        }
        
        return false
    }
    
    static func setCacheValues(_ resourceDetails: [ClientResourceDetail]){
        for resource in resourceDetails {
            ConstantHelper.cache.setObject(resource.unique_name! as NSString, forKey: resource.display_text!, expires: .never)
        }
    }
}

