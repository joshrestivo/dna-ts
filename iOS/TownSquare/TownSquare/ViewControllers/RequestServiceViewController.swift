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
        addDefaultNavUI()
        self.navigationItem.title = "Request Services"
        
        webviewer.delegate = self
        let urlPath = URL(string: "http://www.downtownstl.org/downtown-street-alert-38/")
        let requestObj = URLRequest(url: urlPath!)
        webviewer.loadRequest(requestObj)
    }
}
