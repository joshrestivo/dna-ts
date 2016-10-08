//
//  MarginLabel.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/8/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit

class MarginLabel: UILabel {
    let padding:CGFloat = 8
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: padding)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize{
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding * 2
        let heigth = superContentSize.height + padding * 2
        return CGSize(width: width, height: heigth)
    }

}
