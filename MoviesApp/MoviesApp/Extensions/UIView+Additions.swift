//
//  UIView+Additions.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 01.07.2022.
//

import UIKit

func setupView<T: UIView>(_ view: T = .init(), _ setup: (T) -> Void) -> T {
    setup(view)
    return view
}

func setupAutolayoutView<T: UIView>(_ view: T = .init(), setup: (T) -> Void = { _ in }) -> T {
    setupView(view) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        setup($0)
    }
}
