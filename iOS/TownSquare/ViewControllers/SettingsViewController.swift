//
//  SettingsViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class SettingsViewController: BaseCenterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addDefaultNavUI()
        self.navigationItem.title = ConstantHelper.cache["setting_header_title"] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    
}
