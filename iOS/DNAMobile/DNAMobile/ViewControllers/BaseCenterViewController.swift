//
//  BaseCenterViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class BaseCenterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            
//            self.addLeftBarButtonWithImage(buttonImage: UIImage(named:"ic_menu_black_24dp")!, action: ))
            
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_menu_black_24dp")!, style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            navigationItem.leftBarButtonItem = leftButton
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
             
        }
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
