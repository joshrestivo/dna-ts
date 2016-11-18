//
//  SettingsViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class SettingsLocationViewController: BaseCenterViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    var dataSource = [LocationInfo]()
    var pageIndex = 1
    var isNewsFeedLoading = false
    var hasLoadMore = false
    
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSettingLocation") as! MenuTableViewCell
        let item = dataSource[indexPath.row]
        cell.titleLabel.text = item.name
        cell.iconImageView.image =  UIImage(named: "ic_location_36pt")?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.dataSource[(indexPath as NSIndexPath).row]
        getLocationById(id: item.id)
    }
    
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["setting_location_header_title"] as! String
        self.userTableView?.rowHeight=100
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 100
        self.userTableView.tableFooterView = UIView()
    }
    
    func appendDataSource(_ news:[LocationInfo]){
        if(self.pageIndex == 1){
            self.dataSource = [LocationInfo]()
        }
        
        if (news.count > 0){
            for newsItem in news{
                self.dataSource.append(newsItem)
            }
            
            if(news.count == ConstantHelper.defaultPageSize ){
                self.pageIndex += 1
                hasLoadMore = true;
            }else{
                hasLoadMore = false;
            }
        }
        
        self.hideLoading()
        self.userTableView.reloadData()
    }
    
    func getLocationById(id:Int?){
        ApiService.getLocation(id: id, { (location, isSuccess) in
            if isSuccess {
                ConstantHelper.saveResourceValues(location: location)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setMainVC()
            }
            else{
                self.hideLoading()
            }
        })
    }
    
    func getDataSource(){
        self.showLoading("")
        self.ApiService.getLocations(pageIndex: self.pageIndex,{ (locations, isSuccess) -> () in
            if isSuccess {
                self.appendDataSource(locations)
                self.isNewsFeedLoading = false
            }
            else{
                self.hideLoading()
            }
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (hasLoadMore == false && scrollView.isDragging == false && scrollView.isDecelerating == false){
            
            if(dataSource.count >= ConstantHelper.defaultPageSize * (self.pageIndex - 1) ){
                if(scrollView.contentSize.height - scrollView.frame.size.height <= scrollView.contentOffset.y){
                    self.getDataSource()
                }
            }
        }
    }
}
