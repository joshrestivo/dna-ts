//
//  ApiClient.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/7/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import XMLDictionary

class ApiClient: NSObject {
    class var sharedInstance : ApiClient {
        struct Static {
            static let instance : ApiClient = ApiClient()
        }
        return Static.instance
    }
    
    
    func downloadXMLDataFromUrl(url:String, completion:@escaping ((Bool, Any)->())){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                //convert to dict
                let dict = XMLDictionaryParser.sharedInstance().dictionary(with: data) as! [String: Any]
              
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, dict)
                } else {
                    completion(false, dict)
                }
            }
        })
        task.resume()
    }
    
    func downloadDataFromUrl(url:String, completion:@escaping ((Bool, Any)->())){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                //convert to dict
                
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    completion(true, json)
                } else {
                    completion(false, json)
                }
            }
        })
        task.resume()
    }
    
    func getNews(callback:@escaping ([News]?) -> ()) -> () {
        let urlNew = "http://www.saintlouisdna.org/category/News/feed"
        downloadXMLDataFromUrl(url: urlNew) { (successs, data) in
            if successs {
                var news = [News]()
                if let dict = data as? [String: Any] {
                    if let dictChannle = dict["channel"] as? [String: Any]{
                        if let items = dictChannle["item"] as? [[String: Any]] {
                            
                            for item in items {
                                news.append(News(imageUrl: "http://www.saintlouisdna.org/wp-content/uploads/2016/08/Untitled-design.png", title: item["title"] as! String, content: item["content:encoded"] as! String))
                                //http://www.saintlouisdna.org/wp-content/uploads/2016/08/Untitled-design.png
                            }
//                            print("item \(items)")
                        }
                    }
                }
                callback(news)
            }else{
                callback(nil)
            }
            print("data response")
        }
    }
    
}
