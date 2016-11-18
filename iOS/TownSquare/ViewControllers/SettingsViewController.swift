//
//  SettingsViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class SettingsViewController: BaseCenterViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var settingTableView: UITableView!
    let menuItems = [MenuItem(title: ConstantHelper.cache["setting_about"] as! String,imageName: "ic_info_outline_36pt",type: MenuItemType.leftMenuLocationInfo),MenuItem(title: ConstantHelper.cache["setting_help"] as! String,imageName: "ic_help_36pt",type: MenuItemType.leftMenuLocationInfo),MenuItem(title: ConstantHelper.cache["setting_locations"] as! String,imageName: "ic_location_36pt",type: MenuItemType.leftMenuLocationInfo)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSetting") as! MenuTableViewCell
        let item = menuItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.iconImageView.image =  UIImage(named: item.imageName)?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = self.menuItems[(indexPath as NSIndexPath).row]
        if item.title == ConstantHelper.cache["setting_locations"] as! String {
            self.navigateToView("sidLocationSettings")
        }        
    }
        
    func initScreen(){
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["setting_header_title"] as! String
        self.settingTableView?.rowHeight=130
        self.settingTableView?.rowHeight = UITableViewAutomaticDimension
        self.settingTableView?.estimatedRowHeight = 100
        self.settingTableView.tableFooterView = UIView()
    }
}
