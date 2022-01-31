//
//  SearchRouter.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchRoutingLogic {
    func presentSettingsScreen(from view: UIViewController)
}


final class SearchRouter {
    private var navigationController: UINavigationController?
    init(withNavigationController: UINavigationController?) {
        self.navigationController = withNavigationController
    }
}
// MARK: - SearchRoutingLogic
extension SearchRouter: SearchRoutingLogic {
    func presentSettingsScreen(from view: UIViewController) {
        let searchSettingsViewController = SearchSettingsViewController()
        SearchSettingsConfigurator().configure(viewController: searchSettingsViewController, navigationController: navigationController)
        navigationController?.pushViewController(searchSettingsViewController, animated: true)
    }
}
