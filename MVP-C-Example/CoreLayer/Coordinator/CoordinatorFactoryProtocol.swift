//
//  CoordinatorFactoryProtocol.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator(services: Services) -> ApplicationCoordinator
    func instantiateAuthCoordinator(router: RouterProtocol, services: Services) -> AuthCoordinator
    func instantiateMainCoordinator(router: RouterProtocol, services: Services) -> MainCoordinator
}
