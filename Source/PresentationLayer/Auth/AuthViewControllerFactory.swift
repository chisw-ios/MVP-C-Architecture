//
//  AuthViewControllerFactoryImp.swift
//

import UIKit

protocol AuthViewControllerFactory {
    func instantiateLoginViewController(service: Services, routes: LoginPresenterRoutes) -> LoginViewController
}

extension DependencyProvider: AuthViewControllerFactory {
    
    func instantiateLoginViewController(service: Services, routes: LoginPresenterRoutes) -> LoginViewController {
        let loginViewController = LoginViewController.instantiate(from: .Auth)
        loginViewController.viewModel = LoginPresenter.init(services: services, routes: routes)
        return loginViewController
    }
}
