//
//  Utils.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 19.05.2021.
//  Copyright © 2021 com.chisw. All rights reserved.
//

import UIKit

class Utils {
    
    static func dialNumber(number : String) {

        if let url = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(url) {
              if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
        } else {
                UIAlertController.displayNotification(parmTitle: "" /*L10n.RegistrationViewController.ErrorMessage.title.localized()*/)
       }
    }
    
    func delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
