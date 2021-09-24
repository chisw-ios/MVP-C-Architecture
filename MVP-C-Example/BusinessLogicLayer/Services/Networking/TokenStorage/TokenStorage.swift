//
//  TokenStorage.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation

class TokenStorage {
    
    static var fetchKeyAccessToken: String = "access token"
    static var fetchKeyRefreshToken: String = "refresh token"

    static func setAccessToken(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: fetchKeyAccessToken)
    }
    
    static func setRefreshToken(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: fetchKeyRefreshToken)
    }
    
    static func fetchAccessToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(fetchKeyAccessToken)
    }
    
    static func fetchRefreshToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(fetchKeyRefreshToken)
    }
    
    static func clearTokens() {
        let keychain = KeychainSwift()
        keychain.delete(fetchKeyRefreshToken)
        keychain.delete(fetchKeyAccessToken)
    }
}
