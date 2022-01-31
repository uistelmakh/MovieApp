//
//  FavoritesConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 31.01.2022.
//

import UIKit

/// Конфигуратор VIPER-модуля поиска
final class FavoritesConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? FavoritesViewController
        
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
