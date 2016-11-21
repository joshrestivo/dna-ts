

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
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
    
    var length: Int {
        return self.characters.count
    }
}
