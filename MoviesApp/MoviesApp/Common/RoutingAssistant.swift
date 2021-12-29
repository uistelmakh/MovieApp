//
//  RoutingAssistant.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 13.11.2021.
//

import Foundation
import UIKit

protocol RoutingAssistantProtocol {
    /// Установка начального UINavigationController
    func setRootNavigationController(_ navigationController: UINavigationController)
    
    /// Создание начального UIViewController
    func constructStartViewController(completion: @escaping (_ startViewController: UIViewController?) -> ())
}

/// Протокол создания контейнеров
private protocol ModuleMakerProtocol {
    /// navigationController стек
    func constructEnterContainer() -> UIViewController?

    /// tabBar стек
    func constructTabBarContainer() -> UIViewController?
}

/// Протокол создания модулей
private protocol ModuleConstructorProtocol {
    /// Создание модуля
    func construct(view: UIViewController,
                   with configurator: BaseConfiguratorProtocol,
                   navigationViewController: UINavigationController?) -> UIViewController
}

final class RoutingAssistant {
    static let shared = RoutingAssistant()

    private var rootNavigationController: UINavigationController!
    private var tabBarController: UITabBarController?
    
    //private let reachability = try! Reachability()
    private init(){}
}

// MARK: - RoutingAssistantProtocol
extension RoutingAssistant: RoutingAssistantProtocol {
    func setRootNavigationController(_ navigationController: UINavigationController) {
        rootNavigationController = navigationController
    }
    
    func constructStartViewController(completion: @escaping (UIViewController?) -> ()) {
        
        switch Network.reachability.status {
        case .unreachable:
            completion(TestNetworkViewController())
            
        case .wifi, .wwan:
            completion(self.constructEnterContainer())
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
        
    }
}

// MARK: - ModuleMakerProtocol
extension RoutingAssistant: ModuleMakerProtocol {
    func constructEnterContainer() -> UIViewController? {
        return construct(view: MoviesViewController(), with: MoviesConfigurator(), navigationViewController: rootNavigationController)
    }
    
    func constructTabBarContainer() -> UIViewController? {
        return UIViewController()
    }
}

// MARK: - ModuleConstructorProtocol
extension RoutingAssistant: ModuleConstructorProtocol {
    func construct(view: UIViewController, with configurator: BaseConfiguratorProtocol, navigationViewController: UINavigationController?) -> UIViewController {
        configurator.configure(viewController: view, navigationController: navigationViewController)
        return view
    }
}
