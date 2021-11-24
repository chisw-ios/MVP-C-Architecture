//
//  Services.swift
//
import Foundation
import Alamofire

class Services {

    // MARK: - PUBLIC
    
    lazy var authNetworkServices: AuthService = AuthServiceModule(userService: userService, networker: networker)
    lazy var userService: UserService = UserServiceModule(storage: storage, network: networker)
    // MARK: - PRIVATE
    
    private let storage = RealmStorage()
    private lazy var sessionManager = Session(interceptor: Interceptor(retriers: [RetryPolicy(retryLimit: 3)]))
    private lazy var networker = Networker(sessionManager: sessionManager)
    
    func logOut() {
        self.authNetworkServices.logOut()
        self.renewServices()
        TokenStorage.clearTokens()
        try? self.userService.storeIsAutorized(false)
    }
    
    private func renewServices() {
        userService = UserServiceModule(storage: storage, network: networker)
        authNetworkServices = AuthServiceModule(userService: userService, networker: networker)
    }
}
