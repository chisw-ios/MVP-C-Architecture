//
//  Configuration.swift
//
import Foundation

struct Configuration {
    
    // MARK: - PUBLIC

    static var apiBaseUrl: String = {
        return getPlistRow(key: "API_URL")!
    }()
    
    static var apiVersion: String = {
        return getPlistRow(key: "API_VERSION")!
    }()
        
    // MARK: - PRIVATE
    
    static private func getPlistRow(key: String) -> String? {
        guard let data = infoDictionary[key] as? String else {
            return nil
        }
        return data
    }
    
    static private let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
}
