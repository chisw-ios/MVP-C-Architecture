//
//  BaseCoordinator.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import UIKit

protocol BaseViewControllerProtocol: NSObjectProtocol, Presentable {}

protocol Presentable {
    func toPresent() -> UIViewController?
}

protocol Coordinator: class {
    func start()
}

protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    // MARK: - Public methods
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func removeAllDependency() {
        guard childCoordinators.isEmpty == false else { return }
        childCoordinators.removeAll()
    }
    
    // MARK: - Coordinator
    
    func start() {
        
    }

    
}
