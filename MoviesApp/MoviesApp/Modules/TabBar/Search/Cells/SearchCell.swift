//
//  SearchCell.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 18.01.2022.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    private let imageNetworkService: ImageLoadServiceProtocol = ImageLoadService.shared
    
    private let searchImageView: UIImageView = setupAutolayoutView {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = GlobalConsts.Sizes.cornerRadius
        $0.contentMode = .scaleAspectFill
    }
    
    private let stackView: UIStackView = setupAutolayoutView {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillProportionally
        $0.spacing = 2
    }
    
    private let titleLabel: UILabel = setupAutolayoutView {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .black)
        $0.textColor =  .init(white: 0.4, alpha: 1)
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let yearLabel: UILabel = setupAutolayoutView {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.textColor =  .init(white: 0.6, alpha: 1)
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
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
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(yearLabel)
        
        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchImageView.heightAnchor.constraint(equalToConstant: 120),
            searchImageView.widthAnchor.constraint(equalToConstant: 80),
            searchImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
