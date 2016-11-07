//
//  BaseViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/5/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var sbMain = UIStoryboard(name: "Main", bundle: nil)
    var sbHome = UIStoryboard(name: "Home", bundle: nil)
    var ApiService: ApiClientUsage = ApiClientUsage.shareInstance
    var loadingManager = LoadingManager.shared
    var isProcesing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func navigateToView(_ storyboardId: String) {
        var toView = UIViewController()
        switch storyboardId {
            case "sbNewsDetail" :
                toView = self.sbHome.instantiateViewController(withIdentifier: storyboardId) as! DetailNewViewController
            default: toView = self
        }
        
        if toView == self {
            return
        }
        
        self.navigationController?.pushViewController(toView, animated: true)
    }
    
    func addDefaultNavUI(){
        self.navigationController?.navigationBar.tintColor = ConstantHelper.whiteColor
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName :ConstantHelper.whiteColor]
    }
    
    func showLoading(_ msg: String = "") {
        loadingManager.visibleViewController = self
        loadingManager.showLoading(msg)
        isProcesing = true
    }
    
    func updateLoading(_ msg: String) {
        loadingManager.showLoading(msg)
    }
    
    func hideLoading(){
        loadingManager.hideLoading()
        isProcesing = false
    }
}
