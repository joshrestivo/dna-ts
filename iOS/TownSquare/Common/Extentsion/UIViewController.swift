

import UIKit

private var scrollViewKey : UInt8 = 0

extension UIViewController {
    public func setupKeyboardNotifcationListenerForScrollView(_ scrollView: UIScrollView) {
        setupKeyboardNotifcationListener()
        internalScrollView = scrollView
    }
    
    public func setupKeyboardNotifcationListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    public func removeKeyboardNotificationListeners() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate var internalScrollView: UIScrollView! {
        get {
            return objc_getAssociatedObject(self, &scrollViewKey) as? UIScrollView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &scrollViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! Dictionary<String, AnyObject>
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.int32Value
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.cgRectValue
        let keyboardFrameConvertedToViewFrame = view.convert(keyboardFrame!, from: nil)
        let curveAnimationOption = UIViewAnimationOptions(rawValue: UInt(animationCurve!))
        let options = UIViewAnimationOptions([UIViewAnimationOptions.beginFromCurrentState, curveAnimationOption])
        UIView.animate(withDuration: animationDuration, delay: 0, options:options, animations: { () -> Void in
            let insetHeight = (self.internalScrollView.frame.height + self.internalScrollView.frame.origin.y) - keyboardFrameConvertedToViewFrame.origin.y
            self.internalScrollView.contentInset = UIEdgeInsetsMake(0, 0, insetHeight, 0)
            self.internalScrollView.scrollIndicatorInsets  = UIEdgeInsetsMake(0, 0, insetHeight, 0)
        }) { (complete) -> Void in
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! Dictionary<String, AnyObject>
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.int32Value
        //        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        //        let keyboardFrameConvertedToViewFrame = view.convertRect(keyboardFrame!, fromView: nil)
        let curveAnimationOption = UIViewAnimationOptions(rawValue: UInt(animationCurve!))
        let options = UIViewAnimationOptions([UIViewAnimationOptions.beginFromCurrentState, curveAnimationOption])
        UIView.animate(withDuration: animationDuration, delay: 0, options:options, animations: { () -> Void in
            self.internalScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            self.internalScrollView.scrollIndicatorInsets  = UIEdgeInsetsMake(0, 0, 0, 0)
        }) { (complete) -> Void in
        }
    }
}
