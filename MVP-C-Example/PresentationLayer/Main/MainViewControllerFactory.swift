//
//  Main.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 20.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

protocol MainViewControllerFactory {
    func instantiateTabBarController(routes: TabBarRoutes) -> TabBarController
}

extension DependencyProvider: MainViewControllerFactory {

    func instantiateTabBarController(routes: TabBarRoutes) -> TabBarController {
        let tabBarController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        tabBarController.presenter = TabBarPresenter(routes: routes)
        return tabBarController
    }        
}
