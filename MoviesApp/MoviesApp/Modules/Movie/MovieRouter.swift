//
//  MovieRouter.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 04.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieRoutingLogic {
  
}

final class MovieRouter {
    private var navigationController: UINavigationController?
    init(withNavigationController: UINavigationController?) {
        self.navigationController = withNavigationController
    }
}

// MARK: - MovieRoutingLogic
extension MovieRouter: MovieRoutingLogic {
    
}
