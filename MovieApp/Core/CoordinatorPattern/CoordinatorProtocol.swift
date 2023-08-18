//
//  CoordinatorProtocol.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.08.23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
