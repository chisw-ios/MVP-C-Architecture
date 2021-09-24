//
//  UserService.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation

typealias ProfileResult = (UserProfile?, ErrorMessage?)->()

protocol UserService {
    var userProfile: UserProfile { get set }
    func isAutorized() -> Bool
    func onboardingShown() -> Bool
    func storeOnboardingShown(_ shown: Bool) throws
    func storeIsAutorized(_ isAutorized: Bool) throws
    func store(userPerameters: UserParameters) throws
}

class UserServiceModule {
    
    var userProfile: UserProfile = UserProfile()
    
    private let storage: RealmStorage
    private let network: Networker
    
    init(storage: RealmStorage, network: Networker) {
        self.storage = storage
        self.network = network
    }
}

extension UserServiceModule: UserService {
    
    // MARK: - Network
    
    func getUser(completion: @escaping ProfileResult) {
          
        network.call(type: UserRequestItemsType.getProfile) { [weak self] (result: Resulter<UserProfile>) in
            switch result {
            case let .success(user):
                guard let self = self else { return }
                completion(self.userProfile, nil)
            case let .failure(error):
                print(error.body)
                completion(nil, error)
            }
        }
    }
 
    // MARK: - DATABASE
    
    func store(userPerameters: UserParameters) throws {
        try self.storage.store(object: userPerameters)
    }
    
    func onboardingShown() -> Bool {
        let params = self.storage.realm.object(ofType: UserParameters.self, forPrimaryKey: UserParameters.sharedPrimaryKey)
        return params?.onboardingShown ?? false
    }
    
    func storeOnboardingShown(_ shown: Bool) throws {
        let params = self.storage.realm.object(ofType: UserParameters.self, forPrimaryKey: UserParameters.sharedPrimaryKey)
        try self.storage.realm.write {
            params?.onboardingShown = shown
        }
    }
    
    func isAutorized() -> Bool {
        let params = self.storage.realm.object(ofType: UserParameters.self, forPrimaryKey: UserParameters.sharedPrimaryKey)
        return params?.isAutorized ?? false
    }
    
    func storeIsAutorized(_ isAutorized: Bool) throws {
        let params = self.storage.realm.object(ofType: UserParameters.self, forPrimaryKey: UserParameters.sharedPrimaryKey)
        try self.storage.realm.write {
            params?.isAutorized = isAutorized
        }
    }
    
}
