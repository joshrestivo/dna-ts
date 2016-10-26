//
//  BaseCenterViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class BaseCenterViewController: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        if self.revealViewController() != nil {
            let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_menu_black_24dp")!, style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            navigationItem.leftBarButtonItem = leftButton
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            self.revealViewController().delegate = self
             
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension BaseCenterViewController: SWRevealViewControllerDelegate{
    func revealController(_ revealController: SWRevealViewController!, didMoveTo position: FrontViewPosition) {
        if(position == .left) {
            updateLeft(disableInterac: true)
        } else {
            updateLeft(disableInterac: false)
        }
    }
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
//        if(position == FrontViewPosition.left) {
//            updateLeft(disableInterac: true)
//        } else {
//            updateLeft(disableInterac: false)
//        }
    }
    func updateLeft(disableInterac:Bool){
        self.view.isUserInteractionEnabled  = disableInterac
    }
}
