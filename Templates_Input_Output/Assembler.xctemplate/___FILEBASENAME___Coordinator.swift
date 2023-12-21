//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

import Foundation

class ___VARIABLE_assemblerName___Coordinator: Coordinator {
    // MARK: - Child Coordinators
    var childCoordinators: [Coordinator] = []
    
    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?
    
    // MARK: - Private properties
    private let router: Router
    private let factory: Factory
    private let services: Services
    
    // MARK: - Start
    func start() {
    
    }
    
    // MARK: - Init
    init(router: Router, factory: Factory, services: Services) {
        self.router = router
        self.services = services
        self.factory = factory
    }
}

// MARK: - Private
private extension  ___VARIABLE_assemblerName___Coordinator {
    
}
