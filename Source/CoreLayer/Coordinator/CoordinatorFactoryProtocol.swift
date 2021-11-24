//
//  CoordinatorFactoryProtocol.swift
//
import Foundation

protocol CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator(services: Services) -> ApplicationCoordinator
    func instantiateAuthCoordinator(router: RouterProtocol, services: Services) -> AuthCoordinator
    func instantiateMainCoordinator(router: RouterProtocol, services: Services) -> MainCoordinator
}
