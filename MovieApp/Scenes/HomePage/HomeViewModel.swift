//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

class HomeViewModel {
    var movieNetworkManager: MovieNetworkManager
    var movieData: [MovieData]?
    var reloadCollectionView: (() -> Void)?
    
    init(movieNetworkManager: MovieNetworkManager) {
        self.movieNetworkManager = movieNetworkManager
        self.movieNetworkManager.delegate = self
        self.movieNetworkManager.fetchFilmsNowShowing()
    }
}

extension HomeViewModel: MovieNetworkManagerDelegate {
    func didUpdateMovie(_ movieNetworkManager: MovieNetworkManager, movieData: [MovieData]?) {
        DispatchQueue.main.async { [weak self] in
            self?.movieData = movieData
            self?.reloadCollectionView?()
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
