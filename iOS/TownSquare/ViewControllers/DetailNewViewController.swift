//
//  DetailNewViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/14/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class DetailNewViewController: BaseViewController {

    var titleText: String?
    var content: String?
    var imagePath: String?
    var link: String?
    
    @IBOutlet weak var btnGotoSource: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var btnDataSource: UIButton!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var newImgView: AsyncImageView!
    
    @IBOutlet weak var viewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titleText        
        ConstantHelper.roundButton(btnTitle, color: ConstantHelper.redColor, radius: 5)
        btnTitle.backgroundColor = ConstantHelper.redColor        
        lblContent.text = content == nil ? "" : content
        lblContent.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblContent.sizeToFit()
        btnTitle.setTitle(titleText, for: UIControlState.normal)
        ConstantHelper.addAsyncImage(newImgView, imageUrl: imagePath, imgNotFound: "icon-notFound.jpeg")
        
        let width = UIScreen.main.bounds.size.width
        let lblContentHeight = self.lblContent.frameSize(forAttributedStringWidth: width - 30).height + 50
        let totalHeight = lblContentHeight + imgHeight.constant + 80
        let heightValue =  totalHeight - UIScreen.main.bounds.size.height
        
        if heightValue > 0 {
            viewHeight.constant = heightValue + 50
        }
        
        setupKeyboardNotifcationListenerForScrollView(scrollView)
    }
    
    @IBAction func gotoOriginalLink(_ sender: AnyObject) {
        if link != nil {
            UIApplication.shared.openURL(NSURL(string: link!)! as URL)
        }
        else{
            btnGotoSource.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
