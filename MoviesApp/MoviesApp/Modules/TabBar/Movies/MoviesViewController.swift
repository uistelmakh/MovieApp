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

final class MoviesViewController: UIViewController {
    
    /// Ссылка на слой презентации
    var presenter: MoviesViewControllerOutput?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

// MARK: Setup
private extension MoviesViewController {
    
}

// MARK: - MoviesDisplayLogic
extension MoviesViewController: MoviesDisplayLogic {
    
}
