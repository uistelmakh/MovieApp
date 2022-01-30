//
//  NetworkServiceProtocol.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 25.01.2022.
//

import Foundation

typealias GetSearchMovieResponse = Result<SearchMovieResponse, ErrorResponse>
typealias GetTrendingResponse = Result<TrendingResponse, ErrorResponse>
typealias GetTvPopularResponse = Result<TvPopularResponse, ErrorResponse>

protocol NetworkServiceProtocol {
    /// Получение списка трендовых фильмов, сериалов, актеров
    /// - Parameters:
    ///   - page: Номер страницы
    ///   - completion: Result<SearchMovieResponse, ErrorResponse>
    func getTrending(page: Int, completion: @escaping (GetTrendingResponse) -> Void)
    
    func getTvPopular(page: Int, completion: @escaping (GetTvPopularResponse) -> Void)
    
    /// Получение списка фильмов по поисковому запросу
    /// - Parameters:
    ///   - query: Поисковый запрос
    ///   - includeAdult: Фильмы 18+
    ///   - completion: Result<SearchMovieResponse, ErrorResponse>
    func searchMovie(query: String, includeAdult: Bool, completion: @escaping (GetSearchMovieResponse) -> Void)
    
}
