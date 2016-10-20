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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Left
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = ConstantHelper.redColor
        self.navigationItem.leftBarButtonItem?.tintColor = ConstantHelper.redColor
        
        //right
        self.navigationController?.navigationBar.tintColor = ConstantHelper.whiteColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName :ConstantHelper.whiteColor]
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
    
    public func addLeftBarButtonWithImage(buttonImage: UIImage, action: Selector?) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = leftButton;
    }
    
    public func addRightBarButtonWithImage(buttonImage: UIImage, action: Selector?) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action:action)
        navigationItem.rightBarButtonItem = rightButton;
    }
    
    func pustToNewsDetail() {        
        let secondViewController = self.sbHome.instantiateViewController(withIdentifier: "sbNewsDetail") as! DetailNewViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func addDefaultNavUI(){
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.barTintColor = ConstantHelper.redColor
        //self.navigationController!.navigationBar.backgroundColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
}
