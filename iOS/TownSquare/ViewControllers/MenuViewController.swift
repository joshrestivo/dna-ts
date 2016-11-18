//
//  MenuViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/5/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import Foundation

class MenuViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let menuItems = [MenuItem(title: ConstantHelper.cache["menu_Home"] as! String,imageName: "ic_home_36pt",type: MenuItemType.leftMenuHome),
                     MenuItem(title: ConstantHelper.cache["menu_UpComingEvents"] as! String,imageName: "ic_event_36pt",type: MenuItemType.leftMenuUpCommingEvents),
                     MenuItem(title: ConstantHelper.cache["menu_RequestService"] as! String,imageName: "ic_request_services",type: MenuItemType.leftMenuRequestServices),
                     MenuItem(title: ConstantHelper.cache["menu_LocationInfo"] as! String,imageName: "ic_location_36pt",type: MenuItemType.leftMenuLocationInfo),
                     MenuItem(title: ConstantHelper.cache["menu_StreetAlert"] as! String,imageName: "ic_add_alert_36pt",type: MenuItemType.leftMenuStreetAlert),
                     MenuItem(title: ConstantHelper.cache["menu_Setting"] as! String,imageName: "ic_settings_36pt",type: MenuItemType.leftMenuStreetAlert)]
    
    override func viewDidLoad()
    {
        initScreen()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchTwitterButton(_ sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: "http://www.twitter.com")! as URL)
    }
    
    @IBAction func touchFacebookButton(_ sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: "http://www.facebook.com")! as URL)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellID") as! MenuTableViewCell
        let item = menuItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.iconImageView.image =  UIImage(named: item.imageName)?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let upcomingVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
            let revealVC = self.revealViewController()
            let navUpcomingVC = UINavigationController(rootViewController: upcomingVC)
            revealVC?.pushFrontViewController(navUpcomingVC, animated: true)
            break
        case 1:
            let upcomingVC = self.storyboard?.instantiateViewController(withIdentifier: "UpcomingEventViewControllerID") as! UpcomingEventViewController
            let revealVC = self.revealViewController()
            let navUpcomingVC = UINavigationController(rootViewController: upcomingVC)
            revealVC?.pushFrontViewController(navUpcomingVC, animated: true)

            break
        case 2:
            let upcomingVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestServiceViewControllerID") as! RequestServiceViewController
            let revealVC = self.revealViewController()
            
            let navUpcomingVC = UINavigationController(rootViewController: upcomingVC)
            revealVC?.pushFrontViewController(navUpcomingVC, animated: true)

            break
        case 3:
            let pusVC = self.storyboard?.instantiateViewController(withIdentifier: "vcLocationInfo") as! LocationInfoViewController
            let revealVC = self.revealViewController()
            let navUpcomingVC = UINavigationController(rootViewController: pusVC)
            revealVC?.pushFrontViewController(navUpcomingVC, animated: true)
            break
        case 4:
            let pusVC = self.storyboard?.instantiateViewController(withIdentifier: "vcStreetAlertView") as! StreetAlertViewController
            let revealVC = self.revealViewController()
            let navVC = UINavigationController(rootViewController: pusVC)
            revealVC?.pushFrontViewController(navVC, animated: true)
            break
        case 5:
            let pusVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewControllerID") as! SettingsViewController
            let revealVC = self.revealViewController()
            let navVC = UINavigationController(rootViewController: pusVC)
            revealVC?.pushFrontViewController(navVC, animated: true)
            break
        default:
            break
        }       
    }
    
    func initScreen(){
        self.tableView?.rowHeight=130
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
}

