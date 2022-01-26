//
//  MoviesConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 09.11.2021.
//

import UIKit

/// Конфигуратор VIPER-модуля главной страницы с фильмами
final class MoviesConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? MoviesViewController
        
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        let router = MoviesRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
