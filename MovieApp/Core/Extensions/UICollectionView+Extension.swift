//
//  UICollectionView+Extension.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 08.08.23.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = String(describing: T.self)
        self.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
