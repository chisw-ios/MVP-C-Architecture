//
//  UserRequester.swift
//

import Alamofire

enum UserRequestItemsType {
    case getProfile
}

// MARK: - Extensions
// MARK: - EndPointType

extension UserRequestItemsType: EndPointType {

    var baseURL: String {
        return Configuration.apiBaseUrl
    }
    
    var version: String {
        return Configuration.apiVersion
    }
    
    var path: String {
        switch self {
        case .getProfile:
            return "users/profile"
        }
    }
    
    var servicePath: String {
        switch self {
        case .getProfile:
            return "userService"
        default:
            return "userService"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getProfile:
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
