//
//  StreetDetailViewController.swift
//  TownSquare
//
//  Created by Cuc Nguyen on 11/18/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class StreetDetailViewController: BaseViewController {

    var streetAlert:StreetAlert!
    
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var btnDataSource: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConstantHelper.roundButton(btnTitle, color: ConstantHelper.redColor, radius: 5)
        btnTitle.backgroundColor = ConstantHelper.redColor
        webview.loadRequest(URLRequest(url: URL(string:"http://www.downtownstl.org/downtown-street-alert-38/")!))
        
        self.navigationItem.title = streetAlert.date_in_string
        btnTitle.setTitle(streetAlert.date_in_string, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
