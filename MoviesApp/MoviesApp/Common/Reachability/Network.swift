//
//  Network.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 29.12.2021.
//

import Foundation

/// Проверка интернета
struct Network {
    static var reachability: Reachability!
    
    /// Статус сети
    enum Status: String {
        /// нет сети
        case unreachable
        /// wifi сеть
        case wifi
        /// мобильная сеть
        case wwan
    }
    
    /// Ошибка сети
    enum NetworkError: Error {
        /// Не удалось подключить callout
        case failedToSetCallout
        /// Не удалось установить DispatchQueue
        case failedToSetDispatchQueue
        /// Ошибка создания Reachability с именем хоста
        case failedToCreateWith(String)
        /// Ошибка. Не удалось инициализировать объект Reachability с адресом
        case failedToInitializeWith(sockaddr_in)
    }
}
