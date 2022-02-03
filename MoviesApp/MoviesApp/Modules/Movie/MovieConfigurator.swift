//
//  MovieConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 04.02.2022.
//

import UIKit

/// Конфигуратор VIPER-модуля детальной страницы фильмов
final class MovieConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? MovieViewController
        
        let presenter = MoviePresenter()
        let interactor = MovieInteractor()
        let router = MovieRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
