//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 19.07.23.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
    func movieViewTap()
}

class MovieCell: UICollectionViewCell {
    
    weak var delegate: MovieCellDelegate?
    
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(movieViewTap))
        movieView.addGestureRecognizer(tapGestureRecognizer)
        movieView.isUserInteractionEnabled = true
    }
    
    @objc private func movieViewTap() {
        delegate?.movieViewTap()
    }
}
