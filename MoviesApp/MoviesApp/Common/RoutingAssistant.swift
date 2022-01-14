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
    
    private init(){}
}

// MARK: - RoutingAssistantProtocol
extension RoutingAssistant: RoutingAssistantProtocol {
    func setRootNavigationController(_ navigationController: UINavigationController) {
        rootNavigationController = navigationController
    }
    
    func constructStartViewController(completion: @escaping (UIViewController?) -> ()) {
            completion(self.constructEnterContainer())
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
