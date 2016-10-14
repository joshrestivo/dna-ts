//
//  LocationInfoViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class LocationInfoViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var userTableView: UITableView!
    var data = [BuildingLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
        registerNavbarButton()
        getDataSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingLocationCell") as! LocationInfoCell
        let dataItem = self.data[(indexPath as NSIndexPath).row]
        ConstantHelper.addAsyncImage((cell.photo)!, imageUrl:dataItem.thumbnailUrl, imgNotFound: ConstantHelper.imgNotFound)
        cell.photo.isCircleImage = true
        cell.title?.text = dataItem.txtTitle
        cell.subTitle?.text = dataItem.txtDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.data[(indexPath as NSIndexPath).row]
    }
    
    func backToHome(_ id:AnyObject) {
        let upcomingVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
        let revealVC = self.revealViewController()
        let navUpcomingVC = UINavigationController(rootViewController: upcomingVC)
        revealVC?.pushFrontViewController(navUpcomingVC, animated: true)
    }
    
    func initScreen(){
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationItem.title = "Location Info"
        self.navigationController!.navigationBar.barTintColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.backgroundColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.tintColor = UIColor.white
        
        self.userTableView?.rowHeight=100
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 100
    }
    
    func registerNavbarButton(){
        let leftNavImage = UIImage(named: "icon-nav-left")
        
        let button = UIButton()
        button.setBackgroundImage(leftNavImage, for: UIControlState.normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(LocationInfoViewController.backToHome(_:)), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func getDataSource(){    
        let imgUrl = "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQoNSAIzRg9H-AsYfHjaYw8LF5dRhwAkXh6aBftoxuceT_YRt7-aw"
        let location1 = BuildingLocation(thumbnailUrl: imgUrl, title: "10th St. Lofts", description: "1010 Saint Charles St, 63101")
        let location2 = BuildingLocation(thumbnailUrl: imgUrl, title: "1818 Washington", description: "1818 Washington Awe, 63103")
        let location3 = BuildingLocation(thumbnailUrl: imgUrl, title: "Adler Lofts", description: "2034 Lucas Awe, 63103, 63101")
        let location4 = BuildingLocation(thumbnailUrl: imgUrl, title: "Annex Lofts", description: "1511 Locust St, 63101")
        let location5 = BuildingLocation(thumbnailUrl: imgUrl, title: "Ballpark Lofts", description: "1004 Spruce St, 63102")
        let location6 = BuildingLocation(thumbnailUrl: imgUrl, title: "Blu City Spaces", description: "210 N. 17th St, 63103")
        let location7 = BuildingLocation(thumbnailUrl: imgUrl, title: "City Museum Building", description: "701 N, 15th Street, 63103")
        let location8 = BuildingLocation(thumbnailUrl: imgUrl, title: "City Parc at Pine", description: "1531 Pine St, 63101")
        let location9 = BuildingLocation(thumbnailUrl: imgUrl, title: "City View", description: "1600 Pine St, 63102")
        let location10 = BuildingLocation(thumbnailUrl: imgUrl, title: "Cupples Station Lofts", description: "1023 Spruce St, 63102")
        let location11 = BuildingLocation(thumbnailUrl: imgUrl, title: "Dorsa Lofts", description: "1015 Washington Awe, 63101")
        let location12 = BuildingLocation(thumbnailUrl: imgUrl, title: "Edge Lofts", description: "701 N, 15th Street, 63103")
        data.append(location1)
        data.append(location2)
        data.append(location3)
        data.append(location4)
        data.append(location5)
        data.append(location6)
        data.append(location7)
        data.append(location8)
        data.append(location9)
        data.append(location10)
        data.append(location11)
        data.append(location12)
        self.userTableView.reloadData()
    }
}
