//
//  DetailNewViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/14/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class DetailNewViewController: BaseViewController {

    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.loadRequest(URLRequest(url: URL(string:"http://www.saintlouisdna.org/september-happy-hour-at-busch/")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
