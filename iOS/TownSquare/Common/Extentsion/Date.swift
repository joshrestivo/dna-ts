

import Foundation

let kMinute = 60
let kDay = kMinute * 24
let kWeek = kDay * 7
let kMonth = kDay * 31
let kYear = kDay * 365

extension Date {
    func toDouble() -> Double! {
        return Double(self.formattedWith("yyyyMMdd"))
    }
    
    var formatted:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    func formattedWith(_ format:String = ConstantHelper.defaultDateFormat) -> String {
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
