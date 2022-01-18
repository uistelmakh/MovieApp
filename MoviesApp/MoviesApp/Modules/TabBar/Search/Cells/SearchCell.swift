//
//  SearchCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 18.01.2022.
//

import UIKit

final class SearchCell: UITableViewCell {

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Setup
private extension SearchCell {
    func setup() {
        contentView.backgroundColor = .green
    }
}

// MARK: - Setup Constraints
private extension SearchCell {
    func setupConstraints() {
        
    }
}
