//
//  LaunchInstructor.swift
//
import Foundation

enum LaunchInstructor {
    case auth
    case main
    
    // MARK: - Public methods
    
    static func configure(isAutorized: Bool = false) -> LaunchInstructor {
        
        switch (isAutorized) {
            case (false): return .auth
            case (true): return .main
        }
        
    }
}
