//
//  BaseConfiguratorProtocol.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 15.11.2021.
//

import Foundation
import UIKit

/// Протокол базовой конфигурации сцены
protocol BaseConfiguratorProtocol {
    /// Метод конфигурации сцены
    func configure(viewController: UIViewController, navigationController: UINavigationController?)
}
