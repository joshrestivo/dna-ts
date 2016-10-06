//
//  MenuViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/5/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let menuItems = [MenuItem(title: "Home",imageName: ""),
                     MenuItem(title: "Upcoming Events",imageName: ""),
                     MenuItem(title: "Request Service",imageName: ""),
                     MenuItem(title: "Location Info",imageName: ""),
                     MenuItem(title: "Street Alerts",imageName: ""),
                     MenuItem(title: "Settings",imageName: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func menuTap(_ sender: AnyObject) {
        self.revealViewController().revealToggle(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuItems.count;
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellID") as! MenuTableViewCell
        let item = menuItems[indexPath.row]
        cell.titleLabel.text = item.title

        return cell
      
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
            let pusVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationInfoViewControllerID") as! LocationInfoViewController
            let revealVC = self.revealViewController()
            let navUpcomingVC = UINavigationController(rootViewController: pusVC)
            revealVC?.pushFrontViewController(navUpcomingVC, animated: true)
            break
        case 4:
            let pusVC = self.storyboard?.instantiateViewController(withIdentifier: "StreetAlertViewControllerID") as! StreetAlertViewController
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
}
struct MenuItem {
    var title:String
    var imageName:String
}
