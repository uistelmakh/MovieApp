//
//  Trend.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 26.01.2022.
//

import Foundation


/// Ответ с трендами, возвращаемый API
struct TrendingResponse: Codable {
    let page: Int
    let results: [Trend]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/// Модель трендовых фильмов, сериалов и актеров
struct Trend: Codable {
    let adult: Bool?
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String?
    let overview, posterPath: String
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let mediaType: MediaType
    let firstAirDate, originalName: String?
    let originCountry: [String]?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case name
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tvSerial = "tv"
    
    var ruValue: String {
        switch self {
        case .movie:
            return "кино"
        case .tvSerial:
            return "сериал"
        }
    }
}
