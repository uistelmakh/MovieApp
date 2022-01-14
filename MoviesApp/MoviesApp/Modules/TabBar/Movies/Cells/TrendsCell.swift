//
//  TrendsCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 14.01.2022.
//

import UIKit

/// Ячейка для отображения фильмов в тренде
final class TrendsCell: UITableViewCell {
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
