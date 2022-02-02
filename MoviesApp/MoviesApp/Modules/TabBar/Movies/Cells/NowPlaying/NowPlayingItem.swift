//
//  NowPlayingItem.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 02.02.2022.
//

import UIKit

/// Отображение фильмов в кино
final class NowPlayingItem: UICollectionViewCell {
    private let imageNetworkService: ImageLoadServiceProtocol = ImageLoadService.shared
    
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    func configure(with nowPlaying: NowPlaying) {
        let imageUrlString = GlobalConsts.Network.imageURL + nowPlaying.posterPath
        
        imageNetworkService.getImageFrom(imageUrlString) { [weak self] image in
            guard let image = image else { return }
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension NowPlayingItem {
    func setup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        
        contentView.addSubview(imageView)
    }
}

// MARK: - Setup Constraints
private extension NowPlayingItem {
    func setupConstraints() {
        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
