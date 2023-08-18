//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 19.07.23.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let movieView = MovieView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setUp() {
        selectedBackgroundView = .none
        backgroundColor = .clear
        setUpMovieView()
    }
    
    private func setUpMovieView() {
        addSubview(movieView)
        movieView.stretchOnParent()
        movieView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fillCellWithData(_ model: Films) {
        movieView.fillMovieCell(model)
    }
}
