//
//  NewCollectionViewCell.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var organizationLbl: UILabel!
    
    @IBOutlet weak var newImgView: AsyncImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellValue(txtOrganization: String?, txtTitle:String?, txtContent:String?, imgSrc:String?){
        ConstantHelper.addAsyncImage(newImgView, imageUrl: imgSrc, imgNotFound: "icon-notFound")
        organizationLbl.text = txtOrganization
        titleLbl.text = txtTitle
        contentLbl.text = txtContent
    }
}
