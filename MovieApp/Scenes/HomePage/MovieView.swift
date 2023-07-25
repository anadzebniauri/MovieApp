//
//  MovieView.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 19.07.23.
//

import UIKit

class MovieView: UIView {
    
    //MARK: - Properties
    private let movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.image = Constants.Image.movieImage
        movieImage.setHeight(Constants.MovieImage.height)
//        movieImage.setWidth(150)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.clipsToBounds = true
        categoryLabel.text = Constants.CategoryLabel.text
        categoryLabel.textColor = .black
//        UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        categoryLabel.textAlignment = .center
        categoryLabel.backgroundColor = Constants.Color.categoryLabel
//        categoryLabel.setHeight(Constants.CategoryLabel.height)
        categoryLabel.layer.cornerRadius = Constants.CategoryLabel.cornerRadius
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()
    
    private let movieName: UILabel = {
        let movieName = UILabel()
        movieName.text = Constants.MovieName.text
        movieName.textColor = .white
        movieName.textAlignment = .left
//        movieName.setHeight(Constants.MovieName.height)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        return movieName
    }()
    
    private let movieYear: UILabel = {
        let movieYear = UILabel()
        movieYear.text = Constants.MovieYear.text
        movieYear.textColor = Constants.Color.movieYear
        movieYear.textAlignment = .left
//        movieYear.setHeight(Constants.MovieYear.height)
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        return movieYear
    }()
    
    private let favoritesButton: UIButton = {
        let favoritesButton = UIButton()
        favoritesButton.isUserInteractionEnabled = true
        favoritesButton.setImage(Constants.Image.favoritesButton, for: .normal)
        favoritesButton.setImage(Constants.Image.checkedFavoritesButton, for: .selected)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        return favoritesButton
    }()
    
    //MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    //MARK: - Methods
    private func setUp() {
        setUpMovieImage()
        setUpCategoryTextView()
        setUpMovieName()
        setUpMovieYear()
        setUpFavoritesButton()
    }
    
    private func setUpMovieImage() {
        addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpCategoryTextView() {
        movieImage.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(
                equalTo: movieImage.topAnchor,
                constant: Constants.CategoryLabel.topPadding
            ),
            categoryLabel.trailingAnchor.constraint(
                equalTo: movieImage.trailingAnchor,
                constant: Constants.CategoryLabel.trailingPadding
            )
        ])
    }
    
    private func setUpMovieName() {
        addSubview(movieName)
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(
                equalTo: movieImage.bottomAnchor,
                constant: Constants.MovieName.topPadding
            ),
            movieName.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.MovieName.leadingPadding
            )
        ])
    }
    
    private func setUpMovieYear() {
        addSubview(movieYear)
        
        NSLayoutConstraint.activate([
            movieYear.topAnchor.constraint(equalTo: movieName.bottomAnchor),
            movieYear.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.MovieYear.leadingPadding
            ),
//            movieYear.bottomAnchor.constraint(
//                equalTo: bottomAnchor)
        ])
    }
    
    private func setUpFavoritesButton() {
        addSubview(favoritesButton)
        
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(
                equalTo: movieImage.bottomAnchor,
                constant: Constants.FavoritesButton.topPadding
            ),
            favoritesButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.FavoritesButton.trailingPadding
            ),
//            favoritesButton.bottomAnchor.constraint(
//                lessThanOrEqualTo: movieName.bottomAnchor)
        ])
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTap), for: .touchUpInside)
    }

    @objc private func favoritesButtonTap() {
        favoritesButton.isSelected.toggle()
        print("tap")
    }
}


//MARK: - Constants
private extension MovieView {
    enum Constants {
        enum MovieImage{
            static let height = 226.0
        }
        enum CategoryLabel {
            static let height = 21.0
            static let text = "Comedy"
            static let topPadding = 10.0
            static let trailingPadding = -10.0
            static let cornerRadius = 15.0
        }
        enum MovieName {
            static let height = 23.0
            static let text = "The Boss Baby"
            static let topPadding = 4.0
            static let leadingPadding = 5.0
        }
        enum MovieYear {
            static let height = 16.0
            static let text = "2017"
            static let leadingPadding = 5.0
        }
        enum FavoritesButton {
            static let height = 20.0
            static let topPadding = 3.5
            static let trailingPadding = -4.0
        }
        enum Color {
            static let movieYear = UIColor(red: 128, green: 128, blue: 128, alpha: 1)
            static let categoryLabel = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
        enum Image {
            static let movieImage = UIImage(named: "homeMovieImage")
            static let favoritesButton = UIImage(named: "homeFavoritesButton")
            static let checkedFavoritesButton = UIImage(named: "homeFavoritesCheckedButton")

        }
    }
}
