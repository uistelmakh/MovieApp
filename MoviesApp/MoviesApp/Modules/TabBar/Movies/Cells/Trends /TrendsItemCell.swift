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
    private let titleLabel: UILabel = setupAutolayoutView {
        $0.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let voteAverageLabel: UILabel = setupAutolayoutView {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        $0.layer.masksToBounds = true
    }
    
    private let mediaTypeLabel: UILabel = setupAutolayoutView {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        $0.layer.masksToBounds = true
    }
    
    private let imageView: UIImageView = setupAutolayoutView {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        $0.contentMode = .scaleAspectFill
    }
    
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
        contentView.backgroundColor = .white
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
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        
        // voteAverageLabel
            voteAverageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            voteAverageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            voteAverageLabel.widthAnchor.constraint(equalToConstant: 32),
        
        // mediaTypeLabel
            mediaTypeLabel.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 6),
            mediaTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mediaTypeLabel.widthAnchor.constraint(equalToConstant: 64),
            mediaTypeLabel.heightAnchor.constraint(equalTo: voteAverageLabel.heightAnchor),
        
        // imageView
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
