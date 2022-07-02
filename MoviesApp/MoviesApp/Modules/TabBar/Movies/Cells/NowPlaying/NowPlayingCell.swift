//
//  NowPlayingCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 02.02.2022.
//

import UIKit

/// Ячейка для отображения фильмов в кино
final class NowPlayingCell: UITableViewCell {
    /// делегат для подругзки новых страниц
    weak var loadMoreDelegate: LoadMoreDelegate?
    
    /// массив с фильмами в кино
    var nowPlaying = [NowPlaying]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI
    private let titleLabel: UILabel = setupAutolayoutView {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 24, weight: .black)
        $0.text = "Сейчас в кино"
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NowPlayingItem.self, forCellWithReuseIdentifier: String(describing: NowPlayingItem.self))
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
private extension NowPlayingCell {
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
private extension NowPlayingCell {
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
extension NowPlayingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlaying.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NowPlayingItem.self), for: indexPath) as? NowPlayingItem else { fatalError() }
        
        let nowPlaying = nowPlaying[indexPath.item]
        cell.configure(with: nowPlaying)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == nowPlaying.count - 3 else { return }
        loadMoreDelegate?.loadMore(cellType: .nowPlaying)
    }
}

// MARK: - UICollectionViewDelegate
extension NowPlayingCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NowPlayingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
