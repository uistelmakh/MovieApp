//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 24.01.2022.
//

import Foundation

final class APIRequest {
    
    static let shared = APIRequest()
    
    private init(){}
    
    /// Список эндпоинтов API
    private enum Endpoints {
        /// api ключ
        static let apiKey: String = GlobalConsts.Network.apiKey
        /// url дефолтный
        static let baseUrl: String = GlobalConsts.Network.baseURL
        /// версия апи
        static let apiVersion: Int = 3
        static let defaultQueryItems = [
            URLQueryItem(name: "api_key", value: Endpoints.apiKey),
            URLQueryItem(name: "language", value: "ru-RU")
        ]
        
        /// возвращает собранный url (опциональный)
        private func makeUrl(path: String, queryItems: [URLQueryItem] = []) -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = Endpoints.baseUrl
            components.path = "/\(Endpoints.apiVersion)\(path)"
            components.queryItems = queryItems
            
            return components.url
        }
        
        case getTrending(Int)
        case getTvPopular(Int)
        
        /// url
        var url: URL? {
            switch self {
                /// url трендов текущей недели
            case .getTrending(let page):
                let queryItems = [
                    URLQueryItem(name: "page", value: "\(page)")
                ] + Endpoints.defaultQueryItems
                let path = "/trending/all/week"
                return makeUrl(path: path, queryItems: queryItems)
                
                /// url популярных сериалов на тв
            case .getTvPopular(let page):
                let path = "/tv/popular"
                let queryItems = [
                    URLQueryItem(name: "page", value: "\(page)")
                ] + Endpoints.defaultQueryItems
                return makeUrl(path: path, queryItems: queryItems)
            }
        }
    }
    
    func request<Response: Codable>(url: URL, responseType: Response.Type, completion: @escaping (Response?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = String(describing: HTTPMethod.get)
        
        let handler: (Data?, URLResponse?, Error?) -> Void = {data,response,_ in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else { completion(nil, ErrorResponse.network)
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(responseType, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, ErrorResponse.badData)
            }
        }
        
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url, completionHandler: handler)
        task.resume()
    }
}

// MARK: - NetworkServiceProtocol
extension APIRequest: NetworkServiceProtocol {
    
    // Получаем трендовые фильмы, сериалы и актеров
    func getTrending(page: Int, completion: @escaping (GetTrendingResponse) -> Void) {
        guard let url = Endpoints.getTrending(page).url else { return }
        
        request(url: url, responseType: TrendingResponse.self) { trendingResponse, error in
            if let error = error {
                completion(.failure(error as? ErrorResponse ?? .unknown))
            } else {
                guard let trendingResponse = trendingResponse else { fatalError() }
                completion(.success(trendingResponse))
            }
        }
    }
    
    func searchMovie(query: String, includeAdult: Bool, completion: @escaping (GetSearchMovieResponse) -> Void) {
        
    }
    
    func getTvPopular(page: Int, completion: @escaping (GetTvPopularResponse) -> Void) {
        guard let url = Endpoints.getTvPopular(page).url else { return }
        request(url: url, responseType: TvPopularResponse.self) { tvPopularResponse, error in
            if let error = error {
                completion(.failure(error as? ErrorResponse ?? .unknown))
            } else {
                guard let tvPopularResponse = tvPopularResponse else { fatalError() }
                completion(.success(tvPopularResponse))
            }
        }
    }
}
