//
//  NewCollectionViewCell.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/6/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var newImgView: AsyncImageView!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLbl.sizeToFit()
    }
    
    func setCellValue(title: String?, txtContent:String?, imgSrc:String?){
        ConstantHelper.addAsyncImage(newImgView, imageUrl: imgSrc, imgNotFound: ConstantHelper.imgNotFound)
        titleLbl.text = title
        contentLbl.text = txtContent
    }
}
