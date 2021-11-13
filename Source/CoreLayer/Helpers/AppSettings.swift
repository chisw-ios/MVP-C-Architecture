//
//  AppSettings.swift
//  insk-app
//
//  Created by vlad.kosyi on 23.09.2021.
//

import Foundation

public enum AppSettings {

        public enum key: String {
            case isAtorize = "isAtorize"
        }

        public static subscript(_ key: key) -> Any? { // the parameter key have a enum type `key`
            get { // need use `rawValue` to acess the string
                return UserDefaults.standard.value(forKey: key.rawValue)
            }
            set { // need use `rawValue` to acess the string
                UserDefaults.standard.setValue(newValue, forKey: key.rawValue)
            }
        }
}

extension AppSettings {
    public static func boolValue(_ key: key) -> Bool {
        if let value = AppSettings[key] as? Bool {
            return value
        }
        return false
    }

    public static func stringValue(_ key: key) -> String? {
        if let value = AppSettings[key] as? String {
            return value
        }
        return nil
    }

    public static func intValue(_ key: key) -> Int? {
        if let value = AppSettings[key] as? Int {
            return value
        }
        return nil
    }
}
