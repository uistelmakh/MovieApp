//
//  FavoritesViewController.swift
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

protocol FavoritesDisplayLogic: class
{
  
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic
{
  var interactor: FavoritesBusinessLogic?
  var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?

  
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
  }
  
}
