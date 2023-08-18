//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

protocol HomeViewModelNavigationDelegate: AnyObject {
    func didSelectMovie(id: Int)
}

class HomeViewModel {
    var movieNetworkManager: MovieNetworkManager
    var movieData: [Films]?
    var reloadCollectionView: (() -> Void)?
    var loadNextScreen: ((DetailsViewController) -> Void)?
    var selectedCategory: MovieCategory = .nowShowing
    private var delegate: HomeViewModelNavigationDelegate?
    
    deinit {
        delegate = nil
    }
    
    init(movieNetworkManager: MovieNetworkManager, delegate: HomeViewModelNavigationDelegate?) {
        self.movieNetworkManager = movieNetworkManager
        self.selectedCategory = .nowShowing
        self.delegate = delegate
        self.fetchDataForSelectedCategory()
    }
    
    private func fetchNowShowingData() {
        movieNetworkManager.fetchFilmsNowShowing { [weak self] result in
            switch result {
            case .success(let movieNetworkData):
                self?.movieData = movieNetworkData.films
                self?.reloadCollectionView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchComingSoonData() {
        movieNetworkManager.fetchFilmsComingSoon { [weak self] result in
            switch result {
            case .success(let movieNetworkData):
                self?.movieData = movieNetworkData.films
                self?.reloadCollectionView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchLiveSearchResults(query: String) {
        movieNetworkManager.fetchFilmLiveSearch(query: query) { [weak self] result in
            switch result {
            case .success(let movieNetworkData):
                self?.movieData = movieNetworkData.films
                self?.reloadCollectionView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDataForSelectedCategory() {
        switch selectedCategory {
        case .nowShowing:
            fetchNowShowingData()
        case .comingSoon:
            fetchComingSoonData()
        }
    }
    
    func didSelect(at index: Int) {
        guard let filmId = movieData?[index].film_id else { return }
        self.delegate?.didSelectMovie(id: filmId)
    }
}

enum MovieCategory {
    case nowShowing
    case comingSoon
}
