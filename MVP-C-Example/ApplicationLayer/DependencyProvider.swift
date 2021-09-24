//
//  DependencyProvider.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import UIKit

typealias Factory = CoordinatorFactoryProtocol & ViewControllerFactory
typealias ViewControllerFactory = AuthViewControllerFactory & MainViewControllerFactory 

class DependencyProvider {
    
    private var rootController: UINavigationController
    
    // MARK: App Coordinator
    
    lazy var services = Services()
    internal lazy var aplicationCoordinator = self.instantiateApplicationCoordinator(services: services)
     
    // MARK: - Public func
    
    func start() {
        self.aplicationCoordinator.start()
    }
    
    // MARK: - Initialization
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
}

// MARK: - Extensions
// MARK: - CoordinatorFactoryProtocol

extension DependencyProvider: CoordinatorFactoryProtocol {

    func instantiateApplicationCoordinator(services: Services) -> ApplicationCoordinator {
        let isAutorized = services.userService.isAutorized()
        return ApplicationCoordinator(router: Router(rootController: rootController), factory: self as Factory, launchInstructor: LaunchInstructor.configure(isAutorized: isAutorized), services: services)
    }

    func instantiateAuthCoordinator(router: RouterProtocol, services: Services) -> AuthCoordinator {
        return AuthCoordinator(router: router, factory: self, services: services)
    }

    func instantiateMainCoordinator(router: RouterProtocol, services: Services) -> MainCoordinator {
        return MainCoordinator(router: router, factory: self, services: services)
    }
}

