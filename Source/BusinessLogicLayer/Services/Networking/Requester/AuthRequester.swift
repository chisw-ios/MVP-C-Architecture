//
//  AuthRequester.swift
//

import Foundation

import Alamofire

enum AuthRequestItemsType {
    case authenticated
    case login
    case logOut
    case refreshToken
}

extension AuthRequestItemsType: EndPointType {

    var baseURL: String {
        return Configuration.apiBaseUrl
    }
    
    var version: String {
        return Configuration.apiVersion
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .logOut:
            return "logout"
        case .refreshToken:
            return "refresh"
        case .authenticated:
            return "auth/auth/authenticated"
        }
    }
    
    var servicePath: String {
        switch self {
        default: return "authService"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .login, .logOut, .refreshToken:
            return .post
        case .authenticated:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            var headers: HTTPHeaders = ["Content-Type": "application/json"]
            if let token = TokenStorage.fetchAccessToken() {
                headers["Authorization"] = "Bearer \(token)"
            }
            return headers
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.servicePath + self.version + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default: return JSONEncoding.default
        }
    }

}
