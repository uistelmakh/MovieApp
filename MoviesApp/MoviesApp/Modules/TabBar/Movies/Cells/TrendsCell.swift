//
//  TrendsCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 14.01.2022.
//

import UIKit

/// Ячейка для отображения фильмов в тренде
final class TrendsCell: UITableViewCell {
    
    /// массив с трендовыми фильмами
    var trends = [String]()
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
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
private extension TrendsCell {
    func setup() {
        contentView.backgroundColor = .green
        
        contentView.addSubview(titleLabel)
        
        
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Setup Constraints
private extension TrendsCell {
    func setupConstraints() {
        
    }
}

// MARK: - UICollectionViewDataSource
extension TrendsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "h", for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TrendsCell: UICollectionViewDelegate {
    
}
