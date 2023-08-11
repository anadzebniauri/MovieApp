//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

class HomeViewModel {
    var movieNetworkManager: MovieNetworkManager
    var movieData: [Films]?
    var reloadCollectionView: (() -> Void)?
    var loadNextScreen: ((DetailsViewController) -> Void)?
    
    init(movieNetworkManager: MovieNetworkManager) {
        self.movieNetworkManager = movieNetworkManager
        self.movieNetworkManager.fetchFilmsNowShowing { [weak self] result in
            switch result {
            case .success(let movieNetworkData):
                self?.movieData = movieNetworkData.films
                self?.reloadCollectionView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelect(at index: Int) {
        guard let filmId = movieData?[index].film_id else { return }
        let detailsViewModel = DetailsViewModel(movieId: filmId, movieNetworkManager: movieNetworkManager)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        loadNextScreen?(detailsViewController)
    }
}
