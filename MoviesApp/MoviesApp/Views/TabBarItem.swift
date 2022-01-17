//
//  TabBarItem.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 16.01.2022.
//

import UIKit

class TabBarItem: UITabBarItem {

    override var title: String? {
        get { return nil }
        set { super.title = newValue }
    }
    
    init(image: UIImage) {
        super.init()
        
        self.title = nil
        self.image = image
        self.imageInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: -5.0, right: 0.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
