//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 11.08.23.
//

import Foundation

final class DetailsViewModel {
    
    let movieId: Int
    var reloadPage: ((DetailsNetworkData?) -> Void)?
    
    var movieNetworkManager: MovieNetworkManager
    var detailsData: DetailsNetworkData? {
        didSet {
            reloadPage?(detailsData)
        }
    }
    
    init(movieId: Int, movieNetworkManager: MovieNetworkManager) {
        self.movieId = movieId
        self.movieNetworkManager = movieNetworkManager
    }
        
    func makeNetworkCalls() {
        self.movieNetworkManager.detailsURL(id: movieId, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.detailsData = data
//                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }
}
