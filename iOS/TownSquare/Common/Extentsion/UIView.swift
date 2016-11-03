

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
    
    func loadSubView(_ addView: UIView, callback: (() -> Void)?) {
        self.addSubview(addView)
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn,
                       animations: { addView.frame.origin.y = self.frame.size.height - addView.frame.size.height },
                       completion: { finished in
                        if callback != nil {
                            callback!()
                        }
            }
        )
    }
    
    func loadSubViewFromTop(_ addView: UIView, callback: (() -> Void)?) {
        self.addSubview(addView)
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn,
                       animations: { addView.frame.origin.y = 0 },
                       completion: { finished in
                        if callback != nil {
                            callback!()
                        }
            }
        )
    }
    
    func hideSubView(_ addedView: UIView, callback:(() -> Void)?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut,
                       animations: { addedView.frame.origin.y = self.frame.size.height },
                       completion: { finished in
                        addedView.removeFromSuperview()
                        if callback != nil {
                            callback!()
                        }
            }
        )
    }
    
    func fadeIn(duration: TimeInterval = 0.5, isRepeat: Bool = false) {
        UIView.animate(withDuration: duration,
                       animations: { self.alpha = 1.0 },
                       completion: { finished in
                        if isRepeat {
                            self.fadeOut(duration: duration, isRepeat: isRepeat)
                        }
            }
        )
    }
    
    func fadeOut(duration: TimeInterval = 0.5, isRepeat: Bool = false) {
        UIView.animate(withDuration: duration,
                       animations: { self.alpha = 0.0 },
                       completion: { finished in
                        if isRepeat {
                            self.fadeIn(duration: duration)//, isRepeat: isRepeat)
                        }
            }
        )
    }
    
    func hideSubViewToTop(_ addedView: UIView, callback:(() -> Void)?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut,
                       animations: { addedView.frame.origin.y = 0 - addedView.frame.size.height },
                       completion: { finished in
                        addedView.removeFromSuperview()
                        if callback != nil {
                            callback!()
                        }
            }
        )
    }
    
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let renderContext = UIGraphicsGetCurrentContext()
        self.layer.render(in: renderContext!)
        let imgReturn: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return imgReturn
    }
    
    func roundFullCorner() {
        layer.cornerRadius = layer.frame.size.height / 2
        clipsToBounds = true
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T {
        let v: T? = fromNib(nibNameOrNil)
        return v!
    }
    
    class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = "\(T.self)".components(separatedBy: ".").last!
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
}
