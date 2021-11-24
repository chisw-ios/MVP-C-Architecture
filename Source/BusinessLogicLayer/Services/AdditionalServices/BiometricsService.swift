//
//  BiometricsService.swift
//

import Foundation
import LocalAuthentication

extension LAContext: LAContextProtocol{}

protocol LAContextProtocol {
    func canEvaluatePolicy(_ : LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

enum BioError: Error {
    case General
    case NoEvaluate
}

enum BiometricType{
    case touch
    case face
    case none
}

class BiometricsManager {
    let context: LAContextProtocol
    
    init(context: LAContextProtocol = LAContext() ) {
        self.context = context
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
   
    func authenticateUser(completion: @escaping (Result<String, Error>) -> Void) {
        guard canEvaluatePolicy() else {
            completion( .failure(BioError.NoEvaluate) )
            return
        }
        
        let loginReason = "Log in with Biometrics"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
            if success {
                DispatchQueue.main.async {
                    // User authenticated successfully
                    completion(.success("Success"))
                }
            } else {
                switch evaluateError {
                default: completion(.failure(BioError.General))
                }

            }
        }
    }
        
    func determinateBiometricType() -> BiometricType {
        let authenticationContext = LAContext()
        let _ = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch (authenticationContext.biometryType){
        case .faceID:
            return .face
        case .touchID:
            return .touch
        default:
            return .none
        }
    }
}
