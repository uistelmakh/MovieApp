//
//  SearchCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 18.01.2022.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    private let imageNetworkService: ImageLoadServiceProtocol = ImageLoadService.shared
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        label.textColor =  .init(white: 0.4, alpha: 1)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor =  .init(white: 0.6, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with searchMovie: SearchMovie) {
        titleLabel.text = searchMovie.title
        yearLabel.text = String(searchMovie.releaseDate.prefix(4))

        guard let posterPath = searchMovie.posterPath else { return }

        let imageUrlString = GlobalConsts.Network.imageURL + posterPath

        imageNetworkService.getImageFrom(imageUrlString) { [weak self] image in
            guard let image = image else { return }
            DispatchQueue.main.async { [weak self] in
                self?.searchImageView.image = image
            }
        }
    }

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
        contentView.backgroundColor = .white
    }
}

// MARK: - Setup Constraints
private extension SearchCell {
    func setupConstraints() {
        addSubview(searchImageView)
        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchImageView.heightAnchor.constraint(equalToConstant: 120),
            searchImageView.widthAnchor.constraint(equalToConstant: 80),
            searchImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(yearLabel)
    }
}
