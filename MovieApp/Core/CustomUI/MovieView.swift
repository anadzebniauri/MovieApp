//
//  MovieView.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 19.07.23.
//

import UIKit
import SDWebImage

final class MovieView: UIView {
    
    // MARK: - Properties
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.movieImage
        imageView.clipsToBounds = true
        imageView.setHeight(Constants.MovieImage.height)
        imageView.layer.cornerRadius = Constants.MovieImage.cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = UIColor.appYellow()
        label.layer.cornerRadius = Constants.CategoryLabel.cornerRadius
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.semiBold(ofSize: Constants.CategoryText.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.text = Constants.MovieName.text
        label.textColor = .white
        label.textAlignment = .left
        label.setHeight(Constants.MovieName.height)
        label.font = UIFont.medium(ofSize: Constants.MovieName.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieYear: UILabel = {
        let label = UILabel()
        label.text = Constants.MovieYear.text
        label.textColor = Constants.Color.movieYear
        label.textAlignment = .left
        label.setHeight(Constants.MovieYear.height)
        label.font = UIFont.regular(ofSize: Constants.MovieYear.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.setWidth(Constants.FavoritesButton.width)
        button.setImage(Constants.Image.favoritesButton, for: .normal)
        button.setImage(Constants.Image.checkedFavoritesButton, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genres:[String] = ["Comedy", "Horror", "Romance", "Science Fiction", "Western", "Drama", "Adventure"]

    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    // MARK: - Methods
    private func setUp() {
        setUpMovieImage()
        setUpCategoryLabel()
        setUpCategoryTextConstraints()
        setUpCategoryText()
        setUpFavoritesButton()
        setUpMovieName()
        setUpMovieYear()
    }
    
    private func setUpMovieImage() {
        addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpCategoryLabel() {
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
    
    private func setUpCategoryTextConstraints() {
        categoryLabel.addSubview(categoryText)
        
        NSLayoutConstraint.activate([
            categoryText.topAnchor.constraint(
                equalTo: categoryLabel.topAnchor,
                constant: Constants.CategoryText.topPadding
            ),
            categoryText.leadingAnchor.constraint(
                equalTo: categoryLabel.leadingAnchor,
                constant: Constants.CategoryText.leadingPadding
            ),
            categoryText.trailingAnchor.constraint(
                equalTo: categoryLabel.trailingAnchor,
                constant: Constants.CategoryText.trailingPadding
            ),
            categoryText.bottomAnchor.constraint(
                equalTo: categoryLabel.bottomAnchor,
                constant: Constants.CategoryText.bottomPadding
            )
        ])
    }
    
    private func setUpCategoryText() {
        let randomIndex = Int.random(in: 0..<genres.count)
        let randomGenre = genres[randomIndex]
        categoryText.text = randomGenre
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
            ),
            movieName.trailingAnchor.constraint(
                equalTo: favoritesButton.leadingAnchor,
                constant: Constants.MovieName.trailingPadding)
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
            movieYear.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        ])
        favoritesButton.addTarget(self, action: #selector(navigationBarFavoritesButtonTap), for: .touchUpInside)
    }
    
    @objc private func navigationBarFavoritesButtonTap() {
        favoritesButton.isSelected.toggle()
    }
    
    func fillMovieCell(_ model: Films) {
        movieName.text = model.film_name
        movieYear.text = String(model.year.dropLast(6))
//        movieImage.sd_setImage(with: URL(string: model.image))
        
        if let imageName =  model.image, let imageURL = URL(string: imageName) {
            movieImage.sd_setImage(with: imageURL, placeholderImage: Constants.Image.noImage)
        } else {
            movieImage.image = Constants.Image.noImage
        }
    }
}

// MARK: - Constants
private extension MovieView {
    enum Constants {
        enum MovieImage{
            static let height = 226.0
            static let cornerRadius = 16.0
        }
        enum CategoryLabel {
            static let height = 21.0
            static let text = "Comedy"
            static let topPadding = 10.0
            static let trailingPadding = -10.0
            static let cornerRadius = 15.0
        }
        enum CategoryText {
            static let topPadding = 4.0
            static let leadingPadding = 12.0
            static let trailingPadding = -12.0
            static let bottomPadding = -4.0
            static let fontSize = 14.0
        }
        enum MovieName {
            static let height = 23.0
            static let text = "The Boss Baby"
            static let topPadding = 4.0
            static let leadingPadding = 5.0
            static let fontSize = 14.0
            static let trailingPadding = -6.0
        }
        enum MovieYear {
            static let height = 16.0
            static let text = "2017"
            static let leadingPadding = 5.0
            static let fontSize = 12.0
        }
        enum FavoritesButton {
            static let height = 20.0
            static let width = 21.0
            static let topPadding = 3.5
            static let trailingPadding = -4.0
        }
        enum Color {
            static let movieYear = UIColor(red: 128, green: 128, blue: 128, alpha: 1)
        }
        enum Image {
            static let movieImage = UIImage(named: "homeMovieImage")
            static let favoritesButton = UIImage(named: "homeFavoritesButton")
            static let checkedFavoritesButton = UIImage(named: "homeFavoritesCheckedButton")
            static let noImage = UIImage(named: "no_image")
        }
    }
}
