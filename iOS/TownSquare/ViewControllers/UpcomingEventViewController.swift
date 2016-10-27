//
//  UpcomingEventViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class UpcomingEventViewController: BaseCenterViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var userTableView: UITableView!
    var data = [UpComingEvents]()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "upCommingEventsCell") as! UpComingEventsCell
        let dataItem = self.data[(indexPath as NSIndexPath).row]
        ConstantHelper.addAsyncImage((cell.photo)!, imageUrl:dataItem.thumbnailUrl, imgNotFound: ConstantHelper.imgNotFound)
        cell.photo.isCircleImage = false
        cell.title?.text = dataItem.txtTitle
        cell.subTitle?.text = dataItem.txtDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.data[(indexPath as NSIndexPath).row]
        self.navigateToView("sbNewsDetail")
    }
    
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["upCommingEvents_header_title"] as! String
        self.userTableView?.rowHeight=200
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 200
    }
    
    func getDataSource(){
        let imgUrl = "https://qconnewyork.com/sites/all/themes/qconbs/images/logo2x.png"
        
        let location1 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location2 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location3 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location4 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location5 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location6 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location7 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location8 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location9 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location10 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location11 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
        let location12 = UpComingEvents(thumbnailUrl: imgUrl, title: ConstantHelper.cache["upCommingEvents_title"] as! String, description: ConstantHelper.cache["upCommingEvents_content"] as! String)
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
