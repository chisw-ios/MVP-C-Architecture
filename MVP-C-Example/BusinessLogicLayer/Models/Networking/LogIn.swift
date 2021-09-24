//
//  LogIn.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation

struct AuthResponse: Codable {
    var access_token: String
    var refresh_token: String
}

protocol DocumentProtocol {
    var contentType: String? { get set }
    var filename: String? { get set }
    var type: String? { get set }
    var docData: Data { get set }
}

struct LogIn {
    var phone: String
    var password: String
    
    var jsonForRequest:  [String : Any] {
        return [
            "login": phone,
            "password": password
        ]
    }
}
