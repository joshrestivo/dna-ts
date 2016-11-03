//
//  Utils.swift
//  DealARide
//
//  Created by PhucDoan on 9/11/15.
//  Copyright (c) 2015 PhucDoan. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func spinWithOptions(_ imgView: UIImageView, options: UIViewAnimationOptions, isStop: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.75, delay: 0.0, options: options, animations: { () -> Void in
                    imgView.transform = imgView.transform.rotated(by: CGFloat(M_PI_2))
                })
                { (finished: Bool) -> Void in
                    if(finished) {
                        if !isStop {
                            self.spinWithOptions(imgView, options: UIViewAnimationOptions.curveLinear, isStop: isStop)
                        }
                    }
                }
            }
    }
    static func startSpinning(_ imgView: UIImageView) {
        spinWithOptions(imgView, options: UIViewAnimationOptions.curveLinear, isStop: false)
    }
    static func stopSpinning(_ imgView: UIImageView) {
        spinWithOptions(imgView, options: UIViewAnimationOptions.curveEaseIn, isStop: true)
    }
    
    static func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return result
    }    
}
