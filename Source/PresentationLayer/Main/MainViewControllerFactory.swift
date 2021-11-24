//
//  Main.swift
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
