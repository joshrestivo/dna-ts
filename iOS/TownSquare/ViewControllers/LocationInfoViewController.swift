//
//  LocationInfoViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class LocationInfoViewController: BaseCenterViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var userTableView: UITableView!
    var buildings = [Building]()
    var searchValue = ""
    var pageNumber = 1
    var isSearchMode = false
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
        return buildings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingLocationCell") as! LocationInfoCell
        let dataItem = self.buildings[(indexPath as NSIndexPath).row]
        ConstantHelper.addAsyncImage((cell.photo)!, imageUrl:dataItem.thumbnail_url, imgNotFound: ConstantHelper.imgNotFound)
        cell.photo.isCircleImage = true
        cell.title?.text = dataItem.name
        cell.subTitle?.text = dataItem.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.buildings[(indexPath as NSIndexPath).row]
        self.navigateToView("sbNewsDetail")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.view.endEditing(true)
        searchValue = searchBar.text!
        pageNumber = 1
        self.getDataSource()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        pageNumber = 1
        searchValue = ""
        isSearchMode = false
        self.view.endEditing(true)
        self.buildings.removeAll(keepingCapacity: false)
        self.getDataSource()
    }
    
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["location_info_header_title"] as! String
        self.userTableView?.rowHeight=100
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 100
    }
    
    func filterBuildings(_ buildings:[Building]){
        if(self.pageNumber == 1){
            self.buildings = [Building]()
        }
        
        if (buildings.count > 0){
            for item in buildings{
                self.buildings.append(item)
            }
            
            if(buildings.count == ConstantHelper.defaultPageSize ){
                self.pageNumber += 1
                hasLoadMore = true;
            }else{
                hasLoadMore = false;
            }
        }
        
        self.hideLoading()
        self.userTableView.reloadData()
    }
    
    func getDataSource(){
        self.showLoading("")
        self.ApiService.getBuildings(pageIndex: self.pageNumber,{ (buildings, isSuccess) -> () in
            if isSuccess {
                self.filterBuildings(buildings)
                self.hasLoadMore = false
            }
            else{
                self.hideLoading()
            }
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (hasLoadMore == false && scrollView.isDragging == false && scrollView.isDecelerating == false){
            if(buildings.count >= ConstantHelper.defaultPageSize * (self.pageNumber - 1) ){
                if(scrollView.contentSize.height - scrollView.frame.size.height <= scrollView.contentOffset.y){
                    self.getDataSource()
                }
            }
        }
    }
}
