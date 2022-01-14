//
//  BaseConfiguratorProtocol.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 15.11.2021.
//

import Foundation
import UIKit

/// Протокол базовой конфигурации модуля
protocol BaseConfiguratorProtocol {
    /// Метод конфигурации модуля
    func configure(viewController: UIViewController, navigationController: UINavigationController?)
}
