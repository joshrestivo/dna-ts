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
    var newsFeed = [NewsFeed]()
    var newsIndex = 1
    var hasLoadNewsFeedMore = false
    var isNewsFeedLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
        getNewsFeeds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "upCommingEventsCell") as! UpComingEventsCell
        let dataItem = self.newsFeed[(indexPath as NSIndexPath).row]
        ConstantHelper.addAsyncImage((cell.photo)!, imageUrl:dataItem.thumbnail_url, imgNotFound: ConstantHelper.imgNotFound)
        cell.photo.isCircleImage = true
        cell.title?.text = dataItem.title
        cell.subTitle?.text = dataItem.feedDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.newsFeed[(indexPath as NSIndexPath).row]
        let toView = self.sbHome.instantiateViewController(withIdentifier: "sbNewsDetail") as! DetailNewViewController
        toView.titleText = item.title
        toView.content = item.feedDescription
        toView.imagePath = item.link
        self.navigationController?.pushViewController(toView, animated: true)
    }
    
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["upCommingEvents_header_title"] as? String
        self.userTableView?.rowHeight=200
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 200
    }
    
    func filterNewsFeed(_ news:[NewsFeed]){
        if(self.newsIndex == 1){
            self.newsFeed = [NewsFeed]()
        }
        
        if (news.count > 0){
            for newsItem in news{
                self.newsFeed.append(newsItem)
            }
            
            if(news.count == ConstantHelper.defaultPageSize ){
                self.newsIndex += 1
                hasLoadNewsFeedMore = true;
            }else{
                hasLoadNewsFeedMore = false;
            }
        }
        
        self.hideLoading()
        self.userTableView.reloadData()
    }
    
    func getNewsFeeds(){
        self.showLoading("")
        self.ApiService.getNewsFeeds(pageIndex: self.newsIndex,{ (newsFeedsResult, isSuccess) -> () in
            if isSuccess {
                self.filterNewsFeed(newsFeedsResult)
                self.isNewsFeedLoading = false
            }
            else{
                self.hideLoading()
            }
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (hasLoadNewsFeedMore == false && scrollView.isDragging == false && scrollView.isDecelerating == false){
            
            if(newsFeed.count >= ConstantHelper.defaultPageSize * (self.newsIndex - 1) ){
                if(scrollView.contentSize.height - scrollView.frame.size.height <= scrollView.contentOffset.y){
                    self.getNewsFeeds()
                }
            }
        }
    }
}
