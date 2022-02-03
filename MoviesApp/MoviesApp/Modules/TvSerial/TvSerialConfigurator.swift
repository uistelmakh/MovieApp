//
//  TvSerialConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 04.02.2022.
//

import UIKit

/// Конфигуратор VIPER-модуля детальной страницы фильмов
final class TvSerialConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? TvSerialViewController
        
        let presenter = TvSerialPresenter()
        let interactor = TvSerialInteractor()
        let router = TvSerialRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
