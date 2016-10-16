

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    func setRadiusConer() -> () {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
