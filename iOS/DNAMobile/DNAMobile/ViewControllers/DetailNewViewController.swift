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

        // Do any additional setup after loading the view.
        //TODO: will modify later
        webview.loadRequest(URLRequest(url: URL(string:"http://www.saintlouisdna.org/september-happy-hour-at-busch/")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
