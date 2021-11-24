//
//  UIAlertController.swift
//
import UIKit

extension UIAlertController {
    
    // Error Alert
    class func displayError(_ error: ErrorMessage) {
        let alert = UIAlertController(title: error.title, message: error.body, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        displayAlert(parmAlert: alert)
    }
    
    // Notification
    class func displayNotification(parmTitle: String, parmMessage: String = "", buttonText: String = "Close") {
        let alert = UIAlertController(title: parmTitle, message: parmMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
        displayAlert(parmAlert: alert)
    }
    
    // Notification with action
    class func displayNotification(parmTitle: String, parmMessage: String = "", buttonText: String = "OK", action: VoidBlock, isCancel: Bool = false) {
        let alert = UIAlertController(title: parmTitle, message: parmMessage, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: buttonText, style: .default) { (a) in
            action?()
        }
        let cancelAction = UIAlertAction(title: /*L10n.StarAlertView.CancelButton.title.localized()*/"", style: .cancel) { (a) in
            
        }
        alert.addAction(alertAction)
        if isCancel {
            alert.addAction(cancelAction)
        }
        displayAlert(parmAlert: alert)
    }
    
    // Display Alert
    class func displayAlert(parmAlert: UIAlertController) {
        guard let window = UIWindow.key else { return }
        window.rootViewController?.present(parmAlert, animated: true, completion: nil)
    }
    
    // Function Wrapper
    class func funcHandler(f:(()->())?) {
        f?()
    }
    
}
