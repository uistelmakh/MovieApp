//
//  SearchPresenter.swift
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

/// Логика презентации
protocol SearchPresentationLogic {
    /// Нашли фильмы успешно
    /// - Parameter movies: Найденные фильмы
    func searchMovieSuccess(movies: [SearchMovie])
    
    /// Ошибка когда фильмы не найдены
    func searchMovieFailure()
}

/// Протокол для работы SearchPresenter из SearchViewController
protocol SearchViewControllerOutput {
    /// Переход на экран с настройками
    /// - Parameter view: вьюконтроллер
    func presentSettingsScreen(view: UIViewController)
    
    /// Получаем фильмы
    /// - Parameter query: запрос
    func searchMovie(name query: String)
}

/// Презентер VIPER-модуля поиска
final class SearchPresenter {
    weak var viewController: SearchDisplayLogic?
    var interactor: SearchBusinessLogic?
    var router: SearchRoutingLogic?
}

// MARK: - SearchPresentationLogic
extension SearchPresenter: SearchPresentationLogic {
    func searchMovieSuccess(movies: [SearchMovie]) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.searchResults = movies
        }
    }
    
    func searchMovieFailure() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.searchResults = []
        }
    }
}

// MARK: - SearchViewControllerOutput
extension SearchPresenter: SearchViewControllerOutput {
    func searchMovie(name query: String) {
        interactor?.retrieveSearchMovie(query: query)
    }
    
    func presentSettingsScreen(view: UIViewController) {
        router?.presentSettingsScreen(from: view)
    }
}
