//
//  ProfileConfigurator.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 04.07.2022.
//

import UIKit

final class ProfileConfigurator: BaseConfiguratorProtocol {
    func configure(viewController: UIViewController, navigationController: UINavigationController?) {
        let viewController = viewController as? ProfileViewController
        
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter(withNavigationController: navigationController)

        
        interactor.presenter = presenter
        viewController?.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
}
