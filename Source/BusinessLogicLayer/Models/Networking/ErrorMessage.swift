//
//  ErrorMessage.swift
//

import Foundation

class NetworkError: Codable {
    
    let statusCode: Int?
    let detail: String?
    let type: String?
    let title: String?
}

class ErrorMessage {
    
    var title = ""
    var body = ""
    var code: Int?
    var url: String?
    var message: String?
    
    init(title: String, body: String) {
        self.body = body
        self.title = title
    }
    
    init(title: String = "Error", message: String, code: Int? = nil, url: String? = nil) {
        self.message = message
        self.code = code
        self.url = url
        self.body = message
        self.title = title
    }
    
    class func unwrap(_ error: ErrorMessage?) -> ErrorMessage {
        return error ?? ErrorMessage.defaultError()
    }
    
    class func parseError() -> ErrorMessage {
        return ErrorMessage(title: GlobalConstants.errorAlertTitle, body: GlobalConstants.parseErrorMessage)
    }
    
    class func defaultError() -> ErrorMessage {
        return ErrorMessage(title: GlobalConstants.errorAlertTitle, body: GlobalConstants.genericErrorMessage)
    }
}
