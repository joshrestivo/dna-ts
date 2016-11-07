//
//  ViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/4/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: BaseCenterViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var bulletinCollectionView: UICollectionView!
    @IBOutlet weak var newCollectionView: UICollectionView!
    @IBOutlet weak var viewRequestService: UIView!
    @IBOutlet weak var requestServiceBtn: UIButton!
    @IBOutlet weak var contentLbl: MarginLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblEntryEvent1: MarginLabel!
    @IBOutlet weak var lblEntryEvent2: MarginLabel!
    @IBOutlet weak var lblEntryEvent3: MarginLabel!
    var loadingMoreFootView:UIView?
    
    var newsIndex: Int = 1
    var bulletinIndex: Int = 1
    var news = [News]()
    var hasError = false
    var bulletins = [Bulletins]()
    var newsFeed = [NewsFeed]()
    
    var errorBulletinCount = 0
    var errorNewsFeedCount = 0
    
    var hasErrorInNewsFeed = false
    var hasErrorInBullentin = false
    
    var isBullentinLoading = false
    var isNewsFeedLoading = false
    
    var hasLoadBullentinMore = true
    var hasLoadNewsFeedMore = true
    
    override func viewDidLoad() {
        showLoading("")
        super.viewDidLoad()
        ConstantHelper.roundButton(requestServiceBtn, color: ConstantHelper.buttonBorderColor, radius: 5)
        initScreen()
        requestHomeData()
        setupKeyboardNotifcationListenerForScrollView(scrollView)
    }
    
    func requestHomeData(){
        self.getNewsFeeds()
        self.getBullentins()
        self.getCalendars()
        if self.hasErrorInNewsFeed == true && self.errorNewsFeedCount < 3 {
            self.getNewsFeeds()
        }
        
        if self.hasErrorInBullentin == true && errorBulletinCount < 3 {
            self.getBullentins()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func requestService(_ sender: AnyObject) {
        self.navigateToView("sbNewsDetail")
    }
    
    func homeEvent1Touched(_ sender:AnyObject){
        self.navigateToView("sbNewsDetail")
    }
    
    func homeEvent2Touched(_ sender:AnyObject){
        self.navigateToView("sbNewsDetail")
    }
    
    func homeEvent3Touched(_ sender:AnyObject){
        self.navigateToView("sbNewsDetail")
    }
    
    func initScreen(){
        lblEntryEvent1.text = ConstantHelper.cache["home_middle_left_content1"] as? String
        lblEntryEvent2.text = ConstantHelper.cache["home_middle_left_content2"] as? String
        lblEntryEvent3.text = ConstantHelper.cache["home_middle_left_content3"] as? String
        
        self.navigationItem.title = ConstantHelper.cache["home_header_title"] as! String
        requestServiceBtn.setTitle(ConstantHelper.cache["home_middle_request_button_text"] as! String, for: UIControlState.normal)
        
        let homeEvent1 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.homeEvent1Touched(_:)))
        homeEvent1.numberOfTapsRequired = 1
        lblEntryEvent1.addGestureRecognizer(homeEvent1)
        lblEntryEvent1.isUserInteractionEnabled = true

        let homeEvent2 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.homeEvent2Touched(_:)))
        homeEvent2.numberOfTapsRequired = 1
        lblEntryEvent2.addGestureRecognizer(homeEvent2)
        lblEntryEvent2.isUserInteractionEnabled = true
        
        let homeEvent3 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.homeEvent3Touched(_:)))
        homeEvent3.numberOfTapsRequired = 1
        lblEntryEvent3.addGestureRecognizer(homeEvent3)
        lblEntryEvent3.isUserInteractionEnabled = true
        
        viewRequestService.backgroundColor = ConstantHelper.redColor
        addDefaultNavUI()
    }
    
    func getNewsFeeds(){
        self.showLoading("")
        self.isNewsFeedLoading = true
        self.ApiService.getNewsFeeds(pageIndex: self.newsIndex,{ (newsFeedsResult, isSuccess) -> () in
            if isSuccess {
                self.filterNewsFeed(newsFeedsResult)
                self.isNewsFeedLoading = false
            }
            else{
                self.hideLoading()
                self.errorNewsFeedCount += 1
                self.hasErrorInNewsFeed = true
            }
        })
    }
    
    func getBullentins(){
        self.showLoading("")
        self.isBullentinLoading = true
        self.ApiService.getBulletins(pageIndex: self.newsIndex, { (bulletinsResult, isSuccess) -> () in
            if isSuccess {
                self.filterBullentins(bulletinsResult)
                self.hasErrorInBullentin = false
                self.isBullentinLoading = false
            }
            else{
                self.hideLoading()
                self.errorBulletinCount += 1
                self.hasErrorInBullentin = true
            }
        })
    }
    
    func getCalendars(){
        self.showLoading("")
        self.ApiService.getCalendars({ (calendar, isSuccess) -> () in
            if isSuccess {
                
                self.hideLoading()
            }
            else{
                self.hideLoading()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == self.newCollectionView {
            return newsFeed.count
        }
        else{
            return bulletins.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{        
        return CGSize( width: self.view.bounds.width, height: newCollectionView.bounds.size.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCellID", for: indexPath) as! NewCollectionViewCell
        if collectionView == self.newCollectionView {
            let item = newsFeed[indexPath.row]
            cell.setCellValue(title : item.title, txtContent : item.feedDescription, imgSrc : item.thumbnail_url)
        }
        else{
            let item = bulletins[indexPath.row]
            cell.setCellValue(title :item.title, txtContent : item.bulletinDescription, imgSrc : item.thumbnail_url)
        }
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushToNewDetail", sender: nil)
    }
    
    func filterBullentins(_ bulletinsParam:[Bulletins]){
        if(self.bulletinIndex == 1){
            self.bulletins = [Bulletins]()
        }
        
        if (bulletinsParam.count > 0){
            for bulletin in bulletinsParam{
                self.bulletins.append(bulletin)
            }
            
            if(bulletinsParam.count == ConstantHelper.defaultPageSize ){
                self.bulletinIndex += 1
                hasLoadBullentinMore = true;
            }else{
                hasLoadBullentinMore = false;
            }
        }
        
        self.hideLoading()
        self.bulletinCollectionView.reloadData()
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
        self.newCollectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if ((isBullentinLoading == false || isNewsFeedLoading == false ) && scrollView.isDragging == false && scrollView.isDecelerating == false){
            if(hasLoadNewsFeedMore ||  hasLoadBullentinMore){
                if(scrollView.contentSize.width - scrollView.frame.size.width <= (scrollView.contentOffset.x  + 7)) {
                    if hasLoadNewsFeedMore && isNewsFeedLoading == false{
                        self.getNewsFeeds()
                    }
                    
                    if hasLoadBullentinMore && isBullentinLoading == false {
                        self.getBullentins()
                    }
                }
            }
        }
    }
}
