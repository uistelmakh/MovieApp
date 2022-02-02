//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 09.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Протокол отображения MoviesViewController-а
protocol MoviesDisplayLogic: AnyObject {
    func loadDataDone(trends: [Trend], tvPopulars: [TvPopular], nowPlayings: [NowPlaying])
    
    /// Обновить ячейки
    func reloadRows()
}

/// Главный экран, отображение фильмов
final class MoviesViewController: UIViewController {
    
    // MARK: - Константные текстовки
    private let titleVC = "Киносмотр 🍿"
    
    // MARK: - ViewModels
    var trends = [Trend]()
    var tvPopulars = [TvPopular]()
    var nowPlaying = [NowPlaying]()
    
    // MARK: - UI
    
    /// таблица для отображения коллекций
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TrendsCell.self, forCellReuseIdentifier: String(describing: TrendsCell.self))
        tableView.register(NowPlayingCell.self, forCellReuseIdentifier: String(describing: NowPlayingCell.self))
        tableView.register(TvPopularCell.self, forCellReuseIdentifier: String(describing: TvPopularCell.self))
        return tableView
    }()
    
    // MARK: - Params
    
    /// Ссылка на слой презентации
    var presenter: MoviesViewControllerOutput?
    
    private var service: NetworkServiceProtocol = APIRequest.shared
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadData()
    }
    
}

// MARK: Setup
private extension MoviesViewController {
    func setup() {
        view.backgroundColor = .white
        title = titleVC
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Setup - Constrains
private extension MoviesViewController {
    func setupConstrains() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrendsCell.self), for: indexPath) as? TrendsCell else { fatalError() }
            cell.trends = self.trends
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: NowPlayingCell.self), for: indexPath
            ) as? NowPlayingCell else { fatalError() }
            cell.nowPlaying = self.nowPlaying
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvPopularCell.self), for: indexPath) as? TvPopularCell else { fatalError() }
            
            cell.tvPopulars = self.tvPopulars
            return cell
        default:
            fatalError()
        }
    }
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            // Ячейка трендов
        case 0:
            return 280
            // сейчас в кино
        case 1:
            return 200
        case 2:
            return 180
        default:
            fatalError()
        }
    }
}

// MARK: - MoviesDisplayLogic
extension MoviesViewController: MoviesDisplayLogic {
    func loadDataDone(trends: [Trend], tvPopulars: [TvPopular], nowPlayings: [NowPlaying]) {
        self.trends = trends
        self.tvPopulars = tvPopulars
        self.nowPlaying = nowPlayings
    }
    
    func reloadRows() {
        let trendsIndexPath = IndexPath(row: 0, section: 0)
        let nowPlayingPath = IndexPath(row: 1, section: 0)
        let tvPopularIndexPath = IndexPath(row: 2, section: 0)
        tableView.reloadRows(at: [trendsIndexPath], with: .left)
        tableView.reloadRows(at: [nowPlayingPath], with: .right)
        tableView.reloadRows(at: [tvPopularIndexPath], with: .left)
    }
}
