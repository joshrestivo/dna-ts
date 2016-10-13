//
//  RequestServiceViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class RequestServiceViewController: BaseCenterViewController, UIWebViewDelegate {

    @IBOutlet weak var webviewer: UIWebView!
    
    override func viewDidLoad() {
        initScreen()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        //howLoading("")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
       // self.hideLoading()
    }
    
    func initScreen(){
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationItem.title = "Request Services"
        self.navigationController!.navigationBar.barTintColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.backgroundColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.tintColor = UIColor.white
        
        webviewer.delegate = self
        let urlPath = URL(string: "http://vnexpress.net")
        let requestObj = URLRequest(url: urlPath!)
        webviewer.loadRequest(requestObj)
    }
}
