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
    
    @IBOutlet weak var newImgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.setRadiusConer()
    }
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes!) {
//        super.apply(layoutAttributes)
//        if let attributes = layoutAttributes as? NewLayoutAttributes {
//            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
//        }
//    }
}
