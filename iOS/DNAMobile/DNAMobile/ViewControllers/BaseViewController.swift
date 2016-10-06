//
//  BaseViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/5/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaultColor = UIColor(red: 197.0 / 255.0, green: 0.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = defaultColor
        self.navigationItem.leftBarButtonItem?.tintColor = defaultColor
        self.navigationController?.navigationBar.tintColor = defaultColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName :defaultColor]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func addLeftBarButtonWithImage(buttonImage: UIImage, action: Selector?) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: action)
        navigationItem.leftBarButtonItem = leftButton;
    }
    
    public func addRightBarButtonWithImage(buttonImage: UIImage, action: Selector?) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action:action)
        navigationItem.rightBarButtonItem = rightButton;
    }
}
