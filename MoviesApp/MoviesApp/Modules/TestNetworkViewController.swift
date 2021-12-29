//
//  TestNetworkViewController.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 03.12.2021.
//

import UIKit

class TestNetworkViewController: UIViewController {
    
    var button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        button.backgroundColor = .green
        button.setTitle("update", for: .normal)
        button.addTarget(self, action: #selector(update), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func update() {
        
    }

}
