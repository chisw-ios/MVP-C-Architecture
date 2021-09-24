//
//  MainCoordinator.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 20.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

final class MainCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let services: Services
    private let factory: Factory
    private var tabBarController: UITabBarController?
    
    // MARK: - Private methods
    
    private func showTabBarController() {
                
        let routes = TabBarRoutes {
            print("onLeftButton")
        } onRightButton: {
            print("onRightButton")
        } onError: { error in
            UIAlertController.displayError(error)
        }

        tabBarController = self.factory.instantiateTabBarController(routes: routes)
        let controllers = [ranMainFlow()]
        tabBarController?.viewControllers = controllers
        tabBarController?.selectedIndex = 0
        self.router.setRootModule(tabBarController, hideBar: false)
    }
    
    private func ranMainFlow() -> UIViewController {

        let controller = UIViewController()
        controller.view.backgroundColor = .red
        return controller
    }
    
    // MARK: - Coordinator
    
    override func start() {
        showTabBarController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, factory: Factory, services: Services) {
        self.router = router
        self.factory = factory
        self.services = services
    }
    
}
