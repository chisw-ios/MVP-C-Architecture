//
//  ApplicationCoordinator.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private let factory: Factory
    private let router: RouterProtocol
    private let services: Services
    private var launchInstructor: LaunchInstructor
    
    // MARK: - Coordinator
    
    override func start() {
        switch launchInstructor {
            case .auth: runAuthFlow()
            case .main: runMainFlow()
        }

    }
    
    // MARK: - Private methods
        
    private func runAuthFlow() {
        let coordinator = self.factory.instantiateAuthCoordinator(router: self.router, services: services)
        coordinator.finishFlow = { [unowned self, weak coordinator] in
            // runMainFlow
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: true)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }

    private func runMainFlow() {
        let coordinator = self.factory.instantiateMainCoordinator(router: self.router, services: services)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(isAutorized: false)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, factory: Factory, launchInstructor: LaunchInstructor, services: Services) {
        self.router = router
        self.factory = factory
        self.services = services
        self.launchInstructor = launchInstructor
    }
    
}
