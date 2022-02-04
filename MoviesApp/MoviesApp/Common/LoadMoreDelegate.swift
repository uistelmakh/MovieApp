//
//  LoadMoreDelegate.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 04.02.2022.
//

import Foundation

protocol LoadMoreDelegate: AnyObject {
    func loadMore(cellType: CellType)
}

enum CellType {
    case trend
    case nowPlaying
    case tvPopular
}
