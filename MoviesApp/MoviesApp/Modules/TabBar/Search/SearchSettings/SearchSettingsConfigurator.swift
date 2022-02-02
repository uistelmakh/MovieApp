//
//  SearchSettingsConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 31.01.2022.
//

import UIKit

/// Конфигуратор VIPER-модуля настроек поиска
final class SearchSettingsConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? SearchSettingsViewController
        
        let presenter = SearchSettingsPresenter()
        let interactor = SearchSettingsInteractor()
        let router = SearchSettingsRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
