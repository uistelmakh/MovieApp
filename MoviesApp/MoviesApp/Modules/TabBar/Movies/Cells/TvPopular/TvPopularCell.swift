//
//  TvPopularCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 29.01.2022.
//

import UIKit

/// Ячейка для отображения популярных сериалов на тв
final class TvPopularCell: UITableViewCell {
    /// делегат для подрузки новых страниц
    weak var loadMoreDelegate: LoadMoreDelegate?
    
    /// массив с популярными сериалами на тв
    var tvPopulars = [TvPopular]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI
    private let titleLabel: UILabel = setupAutolayoutView {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .black)
        $0.text = "Популярно на ТВ"
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TvPopularItemCell.self, forCellWithReuseIdentifier: String(describing: TvPopularItemCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
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
private extension TvPopularCell {
    func setup() {
        contentView.backgroundColor = .white
        
        // titleLabel
        contentView.addSubview(titleLabel)
        
        // collectionView
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Setup Constraints
private extension TvPopularCell {
    func setupConstraints() {
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension TvPopularCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvPopulars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TvPopularItemCell.self), for: indexPath) as? TvPopularItemCell else { fatalError() }
        
        let tvPopular = tvPopulars[indexPath.item]
        cell.configure(with: tvPopular)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == tvPopulars.count - 3 else { return }
        loadMoreDelegate?.loadMore(cellType: .tvPopular)
    }
}

// MARK: - UICollectionViewDelegate
extension TvPopularCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout
extension TvPopularCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
