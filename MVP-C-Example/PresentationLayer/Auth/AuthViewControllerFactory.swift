//
//  AuthViewControllerFactoryImp.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 20.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
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
