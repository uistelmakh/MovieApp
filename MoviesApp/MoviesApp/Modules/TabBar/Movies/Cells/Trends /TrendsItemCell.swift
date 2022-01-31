//
//  TrendsItemCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 15.01.2022.
//

import UIKit

/// Отображение фильма трендового в ячейке
final class TrendsItemCell: UICollectionViewCell {
    private let imageNetworkService: ImageLoadServiceProtocol = ImageLoadService.shared
    
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
        label.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
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
        label.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        label.layer.masksToBounds = true
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
    
    func configure(with trend: Trend) {
        titleLabel.text = trend.name ?? trend.title
        voteAverageLabel.text = String(trend.voteAverage)
        mediaTypeLabel.text = trend.mediaType.ruValue
        
        if trend.voteAverage > 7.0 {
            voteAverageLabel.backgroundColor = .systemGreen
        } else if trend.voteAverage < 5.0 {
            voteAverageLabel.backgroundColor = .red
        } else {
            voteAverageLabel.backgroundColor = .lightGray
        }
        
        let imageUrlString = GlobalConsts.Network.imageURL + trend.backdropPath
        
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
private extension TrendsItemCell {
    func setup() {
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        
        contentView.addSubview(imageView)
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
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
