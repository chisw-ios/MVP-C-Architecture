//
//  LaunchInstructor.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
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
