//
//  AppDelegate.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/4/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ApiService: ApiClientUsage = ApiClientUsage.shareInstance
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /*
         self.ApiService.getLocalazation("", longitude: "", callback: { (resObject,isSucces, error) -> () in
             if isSucces == true  {
                 let validData = resObject as! NSDictionary
                 for (key, value) in validData {
                    ConstantHelper.cache.setObject(value as! NSString, forKey: key as! String, expires: .never)
                 }
             }
         })
         */
        
        let stringListObject:String = "[{\"key\": \"menu_Home\", \"value\": \"Home\"}, {\"key\": \"menu_UpComingEvents\", \"value\": \"Upcoming Events\"},{\"key\": \"menu_RequestService\", \"value\": \"Service Organization\"},{\"key\": \"menu_LocationInfo\", \"value\": \"Location Info\"},{\"key\": \"menu_StreetAlert\", \"value\": \"Street Alerts\"},{\"key\": \"menu_HelpResource\", \"value\": \"Helpful Resources\"},{\"key\": \"menu_Setting\", \"value\": \"Settings\"},{\"key\": \"home_header_title\", \"value\": \"DNA - [Location Name]\"},{\"key\": \"home_middle_request_button_text\", \"value\": \"REQUEST SERVICE\"},{\"key\": \"home_middle_left_content1\", \"value\": \"Sep. 30 - 7:00pm - Public lynching \"},{\"key\": \"home_middle_left_content2\", \"value\": \"Oct 1 - 8:30pm - Town Sq. Clearnup\"},{\"key\": \"home_middle_left_content3\", \"value\": \"Oct 2 - City Council Meeting\"},{\"key\": \"home_news_title\", \"value\": \"Downtown Street Alert\"},{\"key\": \"home_news_short_content\", \"value\": \"Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.\"},{\"key\": \"upCommingEvents_title\", \"value\": \"Downtown Street Alert\"},{\"key\": \"upCommingEvents_short_content\", \"value\": \"Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time\"},{\"key\": \"upCommingEvents_header_title\", \"value\": \"Up Coming Events\"}, {\"key\": \"street_alert_header_title\", \"value\": \"Street Alert\"}, {\"key\": \"street_alert_title\", \"value\": \"Downtown Street Alert\"},{\"key\": \"street_alert_short_content\", \"value\": \"Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time\"}, {\"key\": \"request_service_header_title\", \"value\": \"Request service\"}, {\"key\": \"location_info_header_title\", \"value\": \"Location Info\"}, {\"key\": \"location_title\", \"value\": \"10th St. Lofts\"}, {\"key\": \"location_short_content\", \"value\": \"1010 Saint Charles St, 63101\"}, {\"key\": \"setting_header_title\", \"value\": \"Settings\"}]"
        
        let languageKeys = [LocalizationKey](json: stringListObject)        
        if ConstantHelper.existInCache(languageKeys) == false {
            ConstantHelper.setCacheValues(languageKeys)
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this methodvar called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active statvarhere you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
    }
    /*
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DNAMobile")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    */
}

