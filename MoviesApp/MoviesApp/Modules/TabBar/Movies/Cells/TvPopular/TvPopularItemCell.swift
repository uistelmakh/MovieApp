//
//  TvPopularItemCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 29.01.2022.
//

import UIKit

/// Отображение популярных сериалов на тв в ячейке
final class TvPopularItemCell: UICollectionViewCell {
    
    private let imageNetworkService: ImageLoadServiceProtocol = ImageLoadService.shared
    
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    func configure(with tvPopular: TvPopular) {
        titleLabel.text = tvPopular.name
        
        if let backdropPath = tvPopular.backdropPath {
            let imageUrlString = GlobalConsts.Network.imageURL + backdropPath
            imageNetworkService.getImageFrom(imageUrlString) { [weak self] image in
                guard let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }
        } else {
            let image = UIImage(named: "backdrop_placeholder")
            self.imageView.image = image
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
private extension TvPopularItemCell {
    func setup() {
        contentView.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
}

// MARK: - Setup Constraints
private extension TvPopularItemCell {
    func setupConstraints() {
        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        // titleLabel
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
