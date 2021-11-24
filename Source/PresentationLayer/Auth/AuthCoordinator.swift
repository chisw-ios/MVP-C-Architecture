//
//  LoginCoordinator.swift
//

import UIKit

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let factory: Factory
    private let services: Services
    private(set) var userService: UserService
    
    // MARK: - Private methods
        
    private func showLoginViewController()  {
        let loginViewController = getLoginVC()
        self.router.setRootModule(loginViewController, hideBar: true)
    }
        
    private func getLoginVC () -> LoginViewController {

        let routes = LoginPresenterRoutes {
            self.finishFlow?()
        } onError: { error in
            UIAlertController.displayError(error)
        }

        let loginViewController = self.factory.instantiateLoginViewController(service: services, routes: routes)
        return loginViewController
    }
    
    // MARK: - Coordinator

    override func start() {
        showLoginViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, factory: Factory, services: Services) {
        self.router = router
        self.services = services
        self.factory = factory
        self.userService = services.userService
    }
    
}
