//
//  StreetAlertViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class StreetAlertViewController: BaseCenterViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{

    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var userTableView: UITableView!
    var data = [StreetAlert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "streetAlertCell") as! StreetAlertCell
        let dataItem = self.data[(indexPath as NSIndexPath).row]
        ConstantHelper.addAsyncImage((cell.photo)!, imageUrl:dataItem.thumbnailUrl, imgNotFound: ConstantHelper.imgNotFound)
        cell.photo.isCircleImage = false
        cell.title?.text = dataItem.txtTitle
        cell.subTitle?.text = dataItem.txtDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.data[(indexPath as NSIndexPath).row]
        pustToNewsDetail()
    }
    
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = "Street Alert"        
        self.userTableView?.rowHeight=200
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 200
    }
    
    func getDataSource(){
        let imgUrl = "http://www.mappery.com/maps/Poznan-Street-Map.png"
        let location1 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let location2 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "These events have been permitted to close the following streets at the times below; reopenings are subject to change at the discretion of the police")
        let location3 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Walk Route: Walkers begin at 13th Street and Chestnut Street, head south on 13th Street, west on Market Street, north on Jefferson Avenue, east on Olive Street, south on 13th Street, and finish at 13th Street and Pine Street")
        let location4 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let location5 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "These events have been permitted to close the following streets at the times below; reopenings are subject to change at the discretion of the police")
        let location6 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Walk Route: Walkers begin at 13th Street and Chestnut Street, head south on 13th Street, west on Market Street, north on Jefferson Avenue, east on Olive Street, south on 13th Street, and finish at 13th Street and Pine Street.")
        let location7 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Downtown streets will be impacted over the next few days by Q in the Lou (9/23-9/25), St. Jude Walk/Run (9/24), and Families ROC 5K (9/25).  See the street closure information below.  Plan ahead for an alternative route or added travel time")
        let location8 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "These events have been permitted to close the following streets at the times below; reopenings are subject to change at the discretion of the police.")
        let location9 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Downtown streets will be impacted on this extended weekend by the Big Muddy Blues Festival (9/3-9/4) and Labor Day Parade (9/5).  See the street closure information below.  Plan ahead for an alternative route or added travel time")
        let location10 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "These events have been permitted to close the following streets at the times below; reopenings are subject to change at the discretion of the police")
        let location11 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "Downtown streets will be impacted this weekend by the Rise Up Festival, Budweiser Brew Fest and the Moonlight Ramble.  See the street closure information below.  Plan ahead for an alternative route or added travel time")
        let location12 = StreetAlert(thumbnailUrl: imgUrl, title: "Downtown Street Alert", description: "These events have been permitted to close the following streets at the times below; reopenings are subject to change at the discretion of the police")
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
