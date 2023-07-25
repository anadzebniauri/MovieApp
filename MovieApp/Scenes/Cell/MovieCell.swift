//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 19.07.23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let movieView = MovieView()
    
    //<MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectedBackgroundView = .none
        backgroundColor = .clear
        setUpMovieView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setUpMovieView() {
        addSubview(movieView)
        
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: topAnchor),
            movieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        movieView.translatesAutoresizingMaskIntoConstraints = false
    }
}
