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
    @IBOutlet weak var viewFrontLayer: UIView!
    
    var newsIndex: Int = 1
    var bulletinIndex: Int = 1
    var news = [News]()
    var hasError = false
    
    var bulletins = [Bulletins]()
    var newsFeed = [NewsFeed]()
    
    var feedsInARequest = [NewsFeed]()
    var bullentinsInARequest = [Bulletins]()
    var calendars = [CalendarModel]()
    
    var errorBulletinCount = 0
    var errorNewsFeedCount = 0
    
    var validNewsFeed = true
    var validBullentin = true
    var validCallendar = true
    
    var isBullentinLoading = false
    var isNewsFeedLoading = false
    
    var hasLoadBullentinMore = true
    var hasLoadNewsFeedMore = true
    
    override func viewDidLoad() {
        self.showLoading("")
        super.viewDidLoad()
        ConstantHelper.roundButton(requestServiceBtn, color: ConstantHelper.buttonBorderColor, radius: 5)
        initScreen()
        requestHomeData()
        setupKeyboardNotifcationListenerForScrollView(scrollView)
    }
    
    func requestHomeData(){
        getHomeResource { (vailid) -> () in
            self.hideLoading()
            if vailid {
                self.filterNewsFeed(self.feedsInARequest)
                self.filterBullentins(self.bullentinsInARequest)
                self.viewFrontLayer.isHidden = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func requestService(_ sender: AnyObject) {
        //self.navigateToView("sbNewsDetail")
    }
    
    func getDetailValue(index:Int){
        if self.calendars.count == 3 {
            let item = self.calendars[index]
            let toView = self.sbHome.instantiateViewController(withIdentifier: "sbNewsDetail") as! DetailNewViewController
            toView.titleText = item.location
            toView.content = item.calendarDescription
            toView.shorDateString = item.shorDateString!
            self.navigationController?.pushViewController(toView, animated: true)
        }
    }
    
    func homeEvent1Touched(_ sender:AnyObject){
        getDetailValue(index: 0)
    }
    
    func homeEvent2Touched(_ sender:AnyObject){
        getDetailValue(index: 1)
    }
    
    func homeEvent3Touched(_ sender:AnyObject){
        getDetailValue(index: 2)
    }
    
    func initScreen(){
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
        lblEntryEvent1.sizeToFit()
        lblEntryEvent2.sizeToFit()
        lblEntryEvent3.sizeToFit()
        
        viewRequestService.backgroundColor = ConstantHelper.redColor
        addDefaultNavUI()
    }
    
    func getHomeResource(_ callback:@escaping (Bool) -> ()) {
        let validateGroup = DispatchGroup()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            validateGroup.enter()
            self.ApiService.getNewsFeeds(pageIndex: self.newsIndex,{ (newsFeedsResult, isSuccess) -> () in
                if isSuccess {
                    self.feedsInARequest = newsFeedsResult
                    self.isNewsFeedLoading = false
                    self.validNewsFeed = true
                    validateGroup.leave()
                }
                else{
                    self.validNewsFeed = false
                    self.isNewsFeedLoading = true
                    validateGroup.leave()
                }
            })

            validateGroup.enter()
            self.ApiService.getBulletins(pageIndex: self.newsIndex, { (bulletinsResult, isSuccess) -> () in
                if isSuccess {
                    self.bullentinsInARequest = bulletinsResult
                    self.validBullentin = true
                    self.isBullentinLoading = false
                    validateGroup.leave()
                }
                else{
                    validateGroup.leave()
                    self.validBullentin = false
                    self.isBullentinLoading = true
                }
            })
            
            validateGroup.enter()
            self.ApiService.getCalendars({ (calendars, isSuccess) -> () in
                if isSuccess {
                    
                    if calendars.count == 3 {
                        self.calendars = calendars
                        self.lblEntryEvent1.text = calendars[0].calendarDescription == nil ? calendars[0].location : calendars[0].calendarDescription
                        self.lblEntryEvent2.text = calendars[1].calendarDescription == nil ? calendars[1].location : calendars[1].calendarDescription
                        self.lblEntryEvent3.text = calendars[2].calendarDescription == nil ? calendars[2].location : calendars[2].calendarDescription
                        self.validCallendar = true
                        validateGroup.leave()
                    }
                    else{
                        validateGroup.leave()
                        self.validCallendar = false
                    }
                }
                else{
                    validateGroup.leave()
                    self.validCallendar = false
                }
            })
            
            validateGroup.wait(timeout: DispatchTime.distantFuture)
            DispatchQueue.main.async {
                let isValid = self.validNewsFeed && self.validBullentin && self.validCallendar
                callback(isValid)
            }
        }
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
                self.validNewsFeed = true
            }
        })
    }
    
    func getBullentins(){
        self.showLoading("")
        self.isBullentinLoading = true
        self.ApiService.getBulletins(pageIndex: self.newsIndex, { (bulletinsResult, isSuccess) -> () in
            if isSuccess {
                self.filterBullentins(bulletinsResult)
                self.validBullentin = false
                self.isBullentinLoading = false
            }
            else{
                self.hideLoading()
                self.errorBulletinCount += 1
                self.validBullentin = true
            }
        })
    }
    
    func getCalendars(){
        self.showLoading("")
        self.ApiService.getCalendars({ (calendars, isSuccess) -> () in
            if isSuccess {
                if calendars.count == 3 {
                    self.lblEntryEvent1.text = calendars[0].calendarDescription == nil ? calendars[0].location : calendars[0].calendarDescription
                    self.lblEntryEvent2.text = calendars[1].calendarDescription == nil ? calendars[1].location : calendars[1].calendarDescription
                    self.lblEntryEvent3.text = calendars[2].calendarDescription == nil ? calendars[2].location : calendars[2].calendarDescription
                }
                
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
        return UIEdgeInsetsMake(0, 2, 0, 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{        
        return CGSize( width: self.view.bounds.width - 4, height: newCollectionView.bounds.size.height - 5)
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
        
        cell.layer.borderWidth=1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 2
        cell.layer.masksToBounds = true
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        let toView = self.sbHome.instantiateViewController(withIdentifier: "sbNewsDetail") as! DetailNewViewController
        
        if collectionView == self.newCollectionView {
            let item = self.newsFeed[(indexPath as NSIndexPath).row]
            
            toView.link = item.link
            toView.titleText = item.title
            toView.content = item.feedDescription
            toView.imagePath = item.thumbnail_url
        }
        else{
            let item = self.bulletins[(indexPath as NSIndexPath).row]
            toView.titleText = item.title
            toView.content = item.bulletinDescription
            toView.imagePath = item.thumbnail_url
        }
        
        self.navigationController?.pushViewController(toView, animated: true)
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
        
        self.newCollectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (isNewsFeedLoading == false && scrollView.isDragging == false && scrollView.isDecelerating == false){
            if(hasLoadNewsFeedMore){
                if(scrollView.contentSize.width - scrollView.frame.size.width <= (scrollView.contentOffset.x  + 7)) {
                    self.getNewsFeeds()
                }
            }
        }
    }
}
