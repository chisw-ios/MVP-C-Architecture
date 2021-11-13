//
//  AuthService.swift
//

import Foundation

protocol AuthService {
    func login(data: LogIn, completion: @escaping DefaultResult)
    func logOut()
}

class AuthServiceModule {
    
    private let networker: Networker
    private let userService: UserService
    
    init(userService: UserService, networker: Networker) {
        self.networker = networker
        self.userService = userService
    }
    
}

extension AuthServiceModule: AuthService {

    // MARK: - Log in methods

    func login(data: LogIn, completion: @escaping DefaultResult) {
        
        networker.call(type: AuthRequestItemsType.login, params: data.jsonForRequest) { (result: Resulter<AuthResponse>) in
            switch result {
            case let .success(data):
                TokenStorage.setAccessToken(token: data.access_token)
                TokenStorage.setRefreshToken(token: data.refresh_token)
                try? self.userService.storeIsAutorized(true)
                completion(true, nil)
            case let .failure(error):
                completion(false, error)
            }
        }
    }
    
    func logOut() {
        guard let refreshToken = TokenStorage.fetchRefreshToken() else { return }
        let json = ["refreshToken": refreshToken]
        networker.call(type: AuthRequestItemsType.logOut, params: json, handler:  { (responce, error) in
            switch responce {
            case .none:
                print(ErrorMessage.unwrap(error))
            case .some(let data):
                print("success\(data)")
            }
        })
    }
}
