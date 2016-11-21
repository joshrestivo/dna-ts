//
//  StreetAlertViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class StreetAlertViewController: BaseCenterViewController , UISearchBarDelegate{

    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var userTableView: UITableView!
    var dataSource = [StreetAlert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
        getDataSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["street_alert_header_title"] as? String
        self.userTableView?.rowHeight = UITableViewAutomaticDimension
        self.userTableView?.estimatedRowHeight = 200
    }
    
    func getDataSource(){
        showLoading()
        ApiClientUsage.shareInstance.getStreetAlerts( { (streetAlerts, isSuccess) -> () in
          
            self.hideLoading()
            if isSuccess{
                for street in streetAlerts! {
                    self.dataSource.append(street)
                }
                self.userTableView.reloadData()
            }
        })
    }
}

extension StreetAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "streetAlertCell") as! StreetAlertCell
        let dataItem = self.dataSource[(indexPath as NSIndexPath).row]
        ConstantHelper.addAsyncImage((cell.photo)!, imageUrl:dataItem.thumbnailUrl, imgNotFound: ConstantHelper.imgNotFound)
        cell.photo.isCircleImage = false
        cell.title?.text = dataItem.date_in_string
        cell.subTitle?.text = dataItem.link
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "sbStreetDetail") as! StreetDetailViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
        detailVC.streetAlert = self.dataSource[indexPath.row]
    }
}
