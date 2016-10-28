
import Foundation

struct ErrorCodeParam {
    var code: ErrorType! = ErrorType.NONE
    var extParam: String! = ""
    var message: String! = ""
}

class ErrorTypeHelper {
    
    func getErrorCodeFromString(_ sCode: String) -> (ErrorCodeParam) {
        var errCode: ErrorType!
        var errExtendParam: String! = ""
        var errMsg: String! = ""

        if sCode.contains("SYSTEM_ERROR=>") {
            errCode = ErrorType.TEST
            errExtendParam = sCode.replacingOccurrences(of: "SYSTEM_ERROR=>", with: "")
        }else{
            switch sCode {
                default: errCode = ErrorType.UNKNOWN
            }
        }
        
        errMsg = ErrorMessage.getErrorDetail(errCode).msg
        
        return (ErrorCodeParam(code: errCode, extParam: errExtendParam, message: errMsg))
    }
}
