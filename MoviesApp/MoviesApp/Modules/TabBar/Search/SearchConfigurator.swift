//
//  SearchConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 17.01.2022.
//

import UIKit

/// Конфигуратор VIPER-модуля поиска
final class SearchConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? SearchViewController
        
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
