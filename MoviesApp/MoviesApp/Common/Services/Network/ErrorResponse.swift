//
//  ErrorResponse.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 24.01.2022.
//

import Foundation

enum ErrorResponse: Error {
    case unknown
    case network
    case badData

    var message: String {
        switch self {
        case .unknown:
            return "Computer says no"
        case .badData:
            return "Json says no"
        case .network:
            return "Network says no"
        }
    }
}
