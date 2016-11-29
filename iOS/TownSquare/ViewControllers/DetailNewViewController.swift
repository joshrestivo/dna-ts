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
    var shorDateString:String?
    
    @IBOutlet weak var btnGotoSource: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
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
        let height = UIScreen.main.bounds.size.width
        
        let lblContentHeight = self.lblContent.frameSize(forAttributedStringWidth: width - 0).height
        let totalHeight = lblContentHeight + imgHeight.constant
        let heightValue =  totalHeight - height
        
        if heightValue > 0  {
            viewHeight.constant = heightValue
        }
        
        if link == nil {
            btnGotoSource.isHidden = true
        }
        
        if shorDateString != "" {
            lblTitle.isHidden = false
            lblTitle.text = shorDateString
        }
        
        setupKeyboardNotifcationListenerForScrollView(scrollView)
    }
    
    @IBAction func gotoOriginalLink(_ sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: link!)! as URL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
