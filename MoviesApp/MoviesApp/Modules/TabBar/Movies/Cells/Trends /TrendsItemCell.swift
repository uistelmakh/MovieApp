//
//  TrendsItemCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 15.01.2022.
//

import UIKit

/// Отображение фильма в ячейке
final class TrendsItemCell: UICollectionViewCell {
    
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        
        return label
    }()
    
    private let mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    func configure(with trend: Trend) {
        titleLabel.text = trend.name ?? trend.title
        voteAverageLabel.text = String(trend.voteAverage)
        mediaTypeLabel.text = trend.mediaType.ruValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension TrendsItemCell {
    func setup() {
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(mediaTypeLabel)
    }
}

// MARK: - Setup Constraints
private extension TrendsItemCell {
    func setupConstraints() {
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        // voteAverageLabel
        NSLayoutConstraint.activate([
            voteAverageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            voteAverageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        // mediaTypeLabel
        NSLayoutConstraint.activate([
            mediaTypeLabel.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 6),
            mediaTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mediaTypeLabel.widthAnchor.constraint(equalToConstant: 64),
            mediaTypeLabel.heightAnchor.constraint(equalTo: voteAverageLabel.heightAnchor)
        ])
    }
}
