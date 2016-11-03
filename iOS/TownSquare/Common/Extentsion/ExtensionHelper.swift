//
//  ExtensionHelper.swift
//  DealARide
//
//  Created by PhucDoan on 9/19/15.
//  Copyright (c) 2015 PhucDoan. All rights reserved.
//

import Foundation
import GoogleMaps

let kMinute = 60
let kDay = kMinute * 24
let kWeek = kDay * 7
let kMonth = kDay * 31
let kYear = kDay * 365

extension Timer {
    
    // MARK: Schedule timers
    
    /// Create and schedule a timer that will call `block` once after the specified time.
    @discardableResult
    public class func after(_ interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        let timer = Timer.new(after: interval, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` repeatedly in specified time intervals.
    
    @discardableResult
    public class func every(_ interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        let timer = Timer.new(every: interval, block)
        timer.start()
        return timer
    }
    
    /// Create and schedule a timer that will call `block` repeatedly in specified time intervals.
    /// (This variant also passes the timer instance to the block)
    
    @nonobjc @discardableResult
    public class func every(_ interval: TimeInterval, _ block: @escaping (Timer) -> Void) -> Timer {
        let timer = Timer.new(every: interval, block)
        timer.start()
        return timer
    }
    
    // MARK: Create timers without scheduling
    
    /// Create a timer that will call `block` once after the specified time.
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop.
    ///         Use `NSTimer.after` to create and schedule a timer in one step.
    /// - Note: The `new` class function is a workaround for a crashing bug when using convenience initializers (rdar://18720947)
    
    public class func new(after interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, 0, 0, 0) { _ in
            block()
        }
    }
    
    /// Create a timer that will call `block` repeatedly in specified time intervals.
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop.
    ///         Use `NSTimer.every` to create and schedule a timer in one step.
    /// - Note: The `new` class function is a workaround for a crashing bug when using convenience initializers (rdar://18720947)
    
    public class func new(every interval: TimeInterval, _ block: @escaping () -> Void) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0) { _ in
            block()
        }
    }
    
    /// Create a timer that will call `block` repeatedly in specified time intervals.
    /// (This variant also passes the timer instance to the block)
    ///
    /// - Note: The timer won't fire until it's scheduled on the run loop.
    ///         Use `NSTimer.every` to create and schedule a timer in one step.
    /// - Note: The `new` class function is a workaround for a crashing bug when using convenience initializers (rdar://18720947)
    
    @nonobjc public class func new(every interval: TimeInterval, _ block: @escaping (Timer) -> Void) -> Timer {
        var timer: Timer!
        timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0) { _ in
            block(timer)
        }
        return timer
    }
    
    // MARK: Manual scheduling
    
    /// Schedule this timer on the run loop
    ///
    /// By default, the timer is scheduled on the current run loop for the default mode.
    /// Specify `runLoop` or `modes` to override these defaults.
    
    public func start(runLoop: RunLoop = .current, modes: RunLoopMode...) {
        let modes = modes.isEmpty ? [.defaultRunLoopMode] : modes
        
        for mode in modes {
            runLoop.add(self, forMode: mode)
        }
    }
}

extension UIButton {
    override func roundFullCorner() {
        self.layer.cornerRadius = self.layer.frame.size.height / 2
    }
}

extension UIView {
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
    
//    func blink(duration: Double = 1.0, loops: Int = 1) {
//        let loopTimes = loops < 1 ? 1 : loops
//        var loopCount = 0
//        UIView.animateWithDuration(duration, //Time duration you want,
//            animations: { self.fadeOut(duration: duration, isRepeat: true) },
//            completion: { finished in
//                if loopCount < loopTimes {
//                    loopCount += 1
//                    self.blink(duration, loops: loopTimes)
//                }
//            }
//        )
//    }
    
    
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
    
    func toCircleBorder(_ bColor: CGColor = UIColor.hovitButtonCyanColor().cgColor) {
        layer.cornerRadius = layer.frame.size.height / 2
        backgroundColor = UIColor.clear
        layer.borderWidth = 1
        layer.borderColor = bColor
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
extension UITextField {
    func initWithFont(_ txtFont: UIFont) {
        self.font = txtFont
    }
}

extension Date {
    func toDouble() -> Double! {
        return Double(self.formattedWith("yyyyMMdd"))
    }
    
    var formatted:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    func formattedWith(_ format:String = AppSettings.defaultDateControlFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    func greaterThan(_ dateComp: Date) -> Bool {
        return self.compare(dateComp) == ComparisonResult.orderedDescending
    }
    
    func isToday() -> Bool {
        let getDay = self.toDouble()
        let getToday = Date().toDouble()
        
        return getDay == getToday
    }
    
    func timeFrom(_ value: Date)->String {
        let now = value
        let deltaSeconds = Int(fabs(timeIntervalSince(now)))
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        if deltaMinutes < kDay {
            // Hours Ago
            value = Int(floor(Float(deltaMinutes / kMinute)))
            return NSDateTimeAgoLocalizedStrings("Today")
        } else if deltaMinutes < (kDay * 2) {
            // Yesterday
            return NSDateTimeAgoLocalizedStrings("Yesterday")
        } else if deltaMinutes < kWeek {
            // Days Ago
            value = Int(floor(Float(deltaMinutes / kDay)))
            return stringFromFormat("%%d %@days ago", withValue: value)
        } else if deltaMinutes < (kWeek * 2) {
            // Last Week
            return NSDateTimeAgoLocalizedStrings("Last week")
        } else if deltaMinutes < kMonth {
            // Weeks Ago
            value = Int(floor(Float(deltaMinutes / kWeek)))
            return stringFromFormat("%%d %@weeks ago", withValue: value)
        } else if deltaMinutes < (kDay * 61) {
            // Last month
            return NSDateTimeAgoLocalizedStrings("Last month")
        } else if deltaMinutes < kYear {
            // Month Ago
            value = Int(floor(Float(deltaMinutes / kMonth)))
            return stringFromFormat("%%d %@months ago", withValue: value)
        } else if deltaMinutes < (kDay * (kYear * 2)) {
            // Last Year
            return NSDateTimeAgoLocalizedStrings("Last Year")
        }
        
        // Years Ago
        value = Int(floor(Float(deltaMinutes / kYear)))
        return stringFromFormat("%%d %@years ago", withValue: value)
        
    }
    
    func stringFromFormat(_ format: String, withValue value: Int) -> String {
        
        let localeFormat = String(format: format, getLocaleFormatUnderscoresWithValue(Double(value)))
        
        return String(format: NSDateTimeAgoLocalizedStrings(localeFormat), value)
    }
    
    func getLocaleFormatUnderscoresWithValue(_ value: Double) -> String {
        
        let localeCode = Locale.preferredLanguages.first!
        
        if localeCode == "ru" {
            let XY = Int(floor(value)) % 100
            let Y = Int(floor(value)) % 10
            
            if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
                return ""
            }
            
            if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
                return "_"
            }
            
            if Y == 1 && XY != 11 {
                return "__"
            }
        }
        
        return ""
    }
    
    func NSDateTimeAgoLocalizedStrings(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
  
}

extension String {
    
    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) != nil
    }
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) == nil
    }
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = Locale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    // return UTC as NSDate, note* pls check format same as string input
    func toUTCDateTime(_ format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date
    {
        let dateInString = self
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let localDte = dateFormatter.date(from: dateInString) as Date!
        
        dateFormatter.timeZone = TimeZone(identifier: "UTC");
        let utcDte = dateFormatter.string(from: localDte!)
        
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let UtcDate = dateFormatter.date(from: utcDte)!
        
        // Return Parse Date
        return UtcDate
        
    }
    
    // return UTC as NSDate, note* pls check format same as string input
    func toLocalDateTime(_ format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date
    {
        var dateValue = self
        if self.characters.count > 19 {
            let toIndex = self.characters.index(self.startIndex, offsetBy: 19)
            dateValue = self.substring(to: toIndex)
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC");
        
        let dateFromString : Date = dateFormatter.date(from: dateValue)!
        let utcDte = dateFormatter.string(from: dateFromString)
        let returnDate = dateFormatter.date(from: utcDte)!
        
        //Return Parsed Date
        return returnDate
    }
    
    func toDateTime(_ format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.autoupdatingCurrent
        let returnDate = formatter.date(from: self)!
        
        //Return Date same as String
        return returnDate
    }
    
    public func toDouble() -> Double {
        return (NumberFormatter().number(from: self)?.doubleValue)!
    }

}
extension Double {
    func convertToMinute() -> Double {
        let minOriginalValue = self / 60
        let minRoundValue = Utils.roundNumber(minOriginalValue, decimalPlaces: 0)
        return minRoundValue
    }
    func convertToMile() -> Double {
        let mileOriginalValue = self * 0.000621371
        let mileRoundValue = Utils.roundNumber(mileOriginalValue, decimalPlaces: 1)
        return mileRoundValue
    }
    func convertToKilomet() -> Double {
        let kmOriginalValue = self / 1000
        let kmRoundValue = Utils.roundNumber(kmOriginalValue, decimalPlaces: 1)
        return kmRoundValue
    }

    // support for NSTimer
    public var millisecond: TimeInterval  { return self / 1000 }
    public var milliseconds: TimeInterval { return self / 1000 }
    public var ms: TimeInterval           { return self / 1000 }
    
    public var second: TimeInterval       { return self }
    public var seconds: TimeInterval      { return self }
    
    public var minute: TimeInterval       { return self * 60 }
    public var minutes: TimeInterval      { return self * 60 }
    
    public var hour: TimeInterval         { return self * 3600 }
    public var hours: TimeInterval        { return self * 3600 }
    
    public var day: TimeInterval          { return self * 3600 * 24 }
    public var days: TimeInterval         { return self * 3600 * 24 }
    
}
extension UIImageView {
    func toCircleImage() {
        self.layer.cornerRadius = self.layer.frame.size.width / 2
        self.clipsToBounds = true
    }
}
extension UIColor {
    convenience init(hexString: String, alpha: Float) {
        // String -> UInt32
        var rgbValue: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }

    public class func hovitTextDisableBackgroundColor() -> UIColor {
        return UIColor(hexString: "DEDEDE", alpha: 1.0)
    }
    public class func hovitTextDisableForegroundColor() -> UIColor {
        return UIColor(hexString: "B2B2B2", alpha: 1.0)
    }
    public class func hovitHeaderBlueColor() -> UIColor {
        return UIColor(hexString: "1A345A", alpha: 1.0)
    }
    public class func hovitButtonCyanColor() -> UIColor {
        return UIColor(hexString: "00EDD1", alpha: 1.0)
    }
    public class func hovitButtonBlueColor() -> UIColor {
        return UIColor(hexString: "1E3E6B", alpha: 1.0)
    }
    public class func hovitErrorColor() -> UIColor {
        return UIColor(hexString: "ED0000", alpha: 1.0)
    }
    public class func hovitTextBlueColor() -> UIColor {
        return UIColor(hexString: "254A80", alpha: 1.0)
    }
    public class func hovitTextGrayColor() -> UIColor {
        return UIColor(hexString: "959595", alpha: 1.0)
    }
    public class func hovitBlueOverlayColor() -> UIColor {
        return UIColor(hexString: "11233C", alpha: 0.9)
    }
    public class func hovitRouteLineColor() -> UIColor {
        return UIColor(hexString: "00b4ff", alpha: 1.0)
    }
}
extension UIImage
{
    var highestQualityJPEGNSData: Data { return UIImageJPEGRepresentation(self, 1.0)! }
    var highQualityJPEGNSData: Data    { return UIImageJPEGRepresentation(self, 0.75)!}
    var mediumQualityJPEGNSData: Data  { return UIImageJPEGRepresentation(self, 0.5)! }
    var lowQualityJPEGNSData: Data     { return UIImageJPEGRepresentation(self, 0.25)!}
    var lowestQualityJPEGNSData: Data  { return UIImageJPEGRepresentation(self, 0.0)! }
    var supperCompressImage: UIImage {
        let gotImage = UIImage(data: self.mediumQualityJPEGNSData)        
        return UIImage.compressImage(gotImage, compressRatio: 0.5)
    }
}

extension Array where Element: Equatable {
    mutating func removeItem(_ items: [Element]) {
        if items.count == 0 { return }
        for item in items {
            if let index = self.index(of: item) {
                remove(at: index)
            }
        }
    }
    mutating func removeItem(_ item: Element) {
        if let index = self.index(of: item) {
            remove(at: index)
        }
    }
}

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
extension Bundle {
    
    var HovitVersionNumber: String {
        let appVersionNumber = self.infoDictionary?["CFBundleShortVersionString"] as! String!
        return "Hovit \(appVersionNumber!)"
    }
    
    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
extension GMSMapView {
    func disableTitleAndRotate() {
        self.settings.tiltGestures = false
        self.settings.rotateGestures = false
    }
}

extension SlideMenuController {

    var didSettingMenu: Bool {
        get { return isUpdated }
        set { isUpdated = newValue }
    }

}

public var isUpdated: Bool = false
