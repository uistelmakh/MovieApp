//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 14.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

/// Протокол отображения SearchViewController-а
protocol SearchDisplayLogic: AnyObject {
    /// вью модель
    var searchResults: [SearchMovie] { get set }
}

/// Экран поиска фильмов
final class SearchViewController: UIViewController {
    
    // MARK: - Константные текстовки
    private let titleVC = "Поиск 🔎"
    
    // MARK: - UI
    
    /// Контроллер для поиска
    private let searchController = UISearchController(searchResultsController: nil)
    
    /// таблица для отображения коллекций
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchCell.self, forCellReuseIdentifier: String(describing: SearchCell.self))
        return tableView
    }()
    
    // MARK: - ViewModels
    var searchResults = [SearchMovie]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
  
    // MARK: - Params
    /// Ссылка на слой презентации
    var presenter: SearchViewControllerOutput?
    
    private var workItemReference: DispatchWorkItem?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - Setup
private extension SearchViewController {
    func setup() {
        view.backgroundColor = .white
        setupNavigationBar()
        
        // SearchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // tableView
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        title = titleVC
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let filterBarButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(showFilter))
        
        navigationItem.rightBarButtonItem = filterBarButton
    }
    
    @objc func showFilter() {
        presenter?.presentSettingsScreen(view: self)
    }
}

// MARK: - Setup constraints
private extension SearchViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchResults.count == 0 {
            tableView.setEmptyView(title: "Поиск фильмов", message: "Введите название фильма в поиск")
        }
        else {
            tableView.restore()
        }
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchCell.self), for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let searchMovie = searchResults[indexPath.row]
        cell.configure(with: searchMovie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Отменить текущий ожидающий элемент
        workItemReference?.cancel()

        // Получаем данные
        let filmsSearchWorkItem = DispatchWorkItem {
            self.presenter?.searchMovie(name: searchText)
        }
        
        // Сохраняем текущее значение и выполняем через 0.3 секунды
        workItemReference = filmsSearchWorkItem

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: filmsSearchWorkItem)
    }
}

// MARK: - SearchDisplayLogic
extension SearchViewController: SearchDisplayLogic {
    
}
