//
//  HTTPMethod.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 24.01.2022.
//

import Foundation

/// перечисление для установки HTTP-метода нашего запроса
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}
