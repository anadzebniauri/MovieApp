//
//  MainCoordinator.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.08.23.
//

import UIKit

class MainCoordinator: Coordinator {
    private let networkManager = MovieNetworkManager()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = HomeViewController(
            viewModel: HomeViewModel(movieNetworkManager: networkManager, delegate: self)
        )
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func startFavorites() {
        let mainViewController = FavoriteMoviesViewController()
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
}

extension MainCoordinator: HomeViewModelNavigationDelegate {
    func didSelectMovie(id: Int) {
        let detailsViewModel = DetailsViewModel(movieId: id, movieNetworkManager: networkManager)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        navigationController.pushViewController(detailsViewController, animated: false)
    }
}
