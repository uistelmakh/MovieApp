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

protocol MoviesDisplayLogic: AnyObject {
    
}

/// Главный экран, отображение фильмов
final class MoviesViewController: UIViewController {
    
    // MARK: - UI
    
    /// таблица для отображения коллекций
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TrendsCell.self, forCellReuseIdentifier: String(describing: TrendsCell.self))
        return tableView
    }()
    
    /// Ссылка на слой презентации
    var presenter: MoviesViewControllerOutput?
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

// MARK: Setup
private extension MoviesViewController {
    func setup() {
        view.backgroundColor = .white
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrendsCell.self), for: indexPath) as? TrendsCell else { return UITableViewCell() }
        
        
        return cell
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
        default:
            fatalError()
        }
    }
}

// MARK: - MoviesDisplayLogic
extension MoviesViewController: MoviesDisplayLogic {
    
}
