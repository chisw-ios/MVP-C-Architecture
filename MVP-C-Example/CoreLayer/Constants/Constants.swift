//
//  Constants.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation

class GlobalConstants {
    
    // MARK: - Alerts
    static let defaultAlertTitle = "warning"
    static let errorAlertTitle = "error"
    static let genericErrorMessage = "Something went wrong, please try again."
    static let parseErrorMessage = "Parse error"
}

enum Notifications {
    
    static let InvalidRefreshTokenKey = Notification.Name("InvalidRefreshToken")
}
