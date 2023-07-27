//
//  DetailsComponentsView.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 27.07.23.
//

import UIKit

class DetailsComponentsView: UIView {
    
    //MARK: - Properties
    private let movieName: UILabel = {
        let movieName = UILabel()
        movieName.text = Constants.Title.movieName
        movieName.textColor = .white
        movieName.translatesAutoresizingMaskIntoConstraints = false
        return movieName
    }()
    
    private let favoritesButton: UIButton = {
        let favoritesButton = UIButton()
        favoritesButton.setImage(Constants.Image.detailsFavorites, for: .normal)
        favoritesButton.setImage(Constants.Image.detailsCheckedFavorites, for: .selected)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        return favoritesButton
    }()
    
    private let imdbView = DetailsView()
    private let genreView = DetailsView()
    private let timeView = DetailsView()
    private let yearView = DetailsView()
    
    private let imdbStar: UIImageView = {
        let imdbStar = UIImageView()
        imdbStar.image = Constants.Image.imdbStar
        imdbStar.translatesAutoresizingMaskIntoConstraints = false
        return imdbStar
    }()
    
    private let imdbLabel: UILabel = {
        let imdbLabel = UILabel()
        imdbLabel.text = Constants.Title.imdb
        imdbLabel.textColor = Constants.Color.componentsColor
        imdbLabel.translatesAutoresizingMaskIntoConstraints = false
        return imdbLabel
    }()
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.text = Constants.Title.genre
        genreLabel.textColor = Constants.Color.componentsColor
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreLabel
    }()
    
    private let clockImage: UIImageView = {
        let hourImage = UIImageView()
        hourImage.image = Constants.Image.clock
        hourImage.translatesAutoresizingMaskIntoConstraints = false
        return hourImage
    }()
    
    private let hourLabel: UILabel = {
        let hourLabel = UILabel()
        hourLabel.text = Constants.Title.hour
        hourLabel.textColor = Constants.Color.componentsColor
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        return hourLabel
    }()
    
    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.text = Constants.Title.year
        yearLabel.textColor = Constants.Color.componentsColor
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        return yearLabel
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
        setUpMovieName()
        setUpFavoritesButton()
        setUpImdbView()
        setUpImdbStar()
        setUpImdbLabel()
        setUpGenreView()
        setUpGenreLabel()
        setUpTimeView()
        setUpClockImage()
        setUpHourLabel()
        setUpYearView()
        setUpYearLabel()
    }
    
    private func setUpMovieName() {
        addSubview(movieName)
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: topAnchor),
            movieName.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func setUpFavoritesButton() {
        addSubview(favoritesButton)
        
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(equalTo: topAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTap), for: .touchUpInside)
    }

    @objc private func favoritesButtonTap() {
        favoritesButton.isSelected.toggle()
    }
    
    //MARK: - IMDB Rating
    private func setUpImdbView() {
        addSubview(imdbView)
        
        NSLayoutConstraint.activate([
            imdbView.topAnchor.constraint(
                equalTo: movieName.bottomAnchor,
                constant: Constants.imdbView.topPadding
            ),
            imdbView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imdbView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        imdbView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpImdbStar() {
        imdbView.addSubview(imdbStar)
        
        NSLayoutConstraint.activate([
            imdbStar.topAnchor.constraint(
                equalTo: imdbView.topAnchor,
                constant: Constants.imdbStar.topPadding
            ),
            imdbStar.leadingAnchor.constraint(
                equalTo: imdbView.leadingAnchor,
                constant: Constants.imdbStar.leadingPadding
            )
        ])
    }
    
    private func setUpImdbLabel() {
        imdbView.addSubview(imdbLabel)
        
        NSLayoutConstraint.activate([
            imdbLabel.topAnchor.constraint(
                equalTo: imdbView.topAnchor,
                constant: Constants.imdbLabel.topPadding
            ),
            imdbLabel.leadingAnchor.constraint(
                equalTo: imdbStar.trailingAnchor,
                constant: Constants.imdbLabel.leadingPadding
            ),
            imdbLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: imdbView.trailingAnchor,
                constant: Constants.imdbLabel.trailingPadding
            ),
            imdbLabel.bottomAnchor.constraint(
                equalTo: imdbView.bottomAnchor,
                constant: Constants.imdbLabel.bottomPadding
            )
        ])
    }
    
    //MARK: - Genre
    private func setUpGenreView() {
        addSubview(genreView)
        
        NSLayoutConstraint.activate([
            genreView.topAnchor.constraint(
                equalTo: movieName.bottomAnchor,
                constant: Constants.GenreView.topPadding
            ),
            genreView.leadingAnchor.constraint(
                equalTo: imdbView.trailingAnchor,
                constant: Constants.GenreView.leadingPadding
            ),
            genreView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        genreView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpGenreLabel() {
        genreView.addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(
                equalTo: genreView.topAnchor,
                constant: Constants.GenreLabel.topPadding
            ),
            genreLabel.leadingAnchor.constraint(
                equalTo: genreView.leadingAnchor,
                constant: Constants.GenreLabel.leadingPadding
            ),
            genreLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: genreView.trailingAnchor,
                constant: Constants.GenreLabel.trailingPadding),
            genreLabel.bottomAnchor.constraint(
                equalTo: genreView.bottomAnchor,
                constant: Constants.GenreLabel.bottomPadding)
        ])
    }
    
    //MARK: - Movie Duration
    private func setUpTimeView() {
        addSubview(timeView)
        
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(
                equalTo: movieName.bottomAnchor,
                constant: Constants.TimeView.topPadding
            ),
            timeView.leadingAnchor.constraint(
                equalTo: genreView.trailingAnchor,
                constant: Constants.TimeView.leadingPadding
            ),
            timeView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        timeView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpClockImage() {
        timeView.addSubview(clockImage)
        
        NSLayoutConstraint.activate([
            clockImage.topAnchor.constraint(
                equalTo: timeView.topAnchor,
                constant: Constants.ClockImage.topPadding
            ),
            clockImage.leadingAnchor.constraint(
                equalTo: timeView.leadingAnchor,
                constant: Constants.ClockImage.leadingPadding
            )
        ])
    }
    
    private func setUpHourLabel() {
        timeView.addSubview(hourLabel)
        
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(
                equalTo: timeView.topAnchor,
                constant: Constants.HourLabel.topPadding
            ),
            hourLabel.leadingAnchor.constraint(
                equalTo: clockImage.trailingAnchor,
                constant: Constants.HourLabel.leadingPadding
            ),
            hourLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: timeView.trailingAnchor,
                constant: Constants.HourLabel.trailingPadding
            ),
            hourLabel.bottomAnchor.constraint(
                equalTo: timeView.bottomAnchor,
                constant: Constants.HourLabel.bottomPadding
            )
        ])
    }
    
    //MARK: - Movie Year
    private func setUpYearView() {
        addSubview(yearView)
        
        NSLayoutConstraint.activate([
            yearView.topAnchor.constraint(
                equalTo: movieName.bottomAnchor,
                constant: Constants.YearView.topPadding
            ),
            yearView.leadingAnchor.constraint(
                equalTo: timeView.trailingAnchor,
                constant: Constants.YearView.leadingPadding
            ),
            yearView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        yearView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpYearLabel() {
        yearView.addSubview(yearLabel)
        
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(
                equalTo: yearView.topAnchor,
                constant: Constants.YearLabel.topPadding
            ),
            yearLabel.leadingAnchor.constraint(
                equalTo: yearView.leadingAnchor,
                constant: Constants.YearLabel.leadingPadding
            ),
            yearLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: yearView.trailingAnchor,
                constant: Constants.YearLabel.trailingPadding
            ),
            yearLabel.bottomAnchor.constraint(
                equalTo: yearView.bottomAnchor,
                constant: Constants.YearLabel.bottomPadding
            )
        ])
    }
}

//MARK: - Constants
private extension DetailsComponentsView {
    enum Constants {
        enum Title {
            static let movieName = "The Atonement"
            static let imdb = "7.9"
            static let genre = "Romance"
            static let hour = "1h 50m"
            static let year = "2007"
        }
        enum imdbView {
            static let topPadding = 12.0
        }
        enum imdbStar {
            static let topPadding = 6.0
            static let leadingPadding = 10.0
        }
        enum imdbLabel {
            static let topPadding = 4.0
            static let leadingPadding = 4.0
            static let trailingPadding = -10.0
            static let bottomPadding = -4.0
        }
        enum GenreView {
            static let topPadding = 12.0
            static let leadingPadding = 8.0
        }
        enum GenreLabel {
            static let topPadding = 4.0
            static let leadingPadding = 10.0
            static let trailingPadding = -10.0
            static let bottomPadding = -4.0
        }
        enum TimeView {
            static let topPadding = 12.0
            static let leadingPadding = 8.0
        }
        enum ClockImage {
            static let topPadding = 4.0
            static let leadingPadding = 10.0
        }
        enum HourLabel {
            static let topPadding = 4.0
            static let leadingPadding = 4.0
            static let trailingPadding = -10.0
            static let bottomPadding = -4.0
        }
        enum YearView {
            static let topPadding = 12.0
            static let leadingPadding = 8.0
        }
        enum YearLabel {
            static let topPadding = 4.0
            static let leadingPadding = 10.0
            static let trailingPadding = -10.0
            static let bottomPadding = -4.0
        }
        enum Image {
            static let detailsFavorites = UIImage(named: "DetailsFavorites")
            static let detailsCheckedFavorites = UIImage(named: "DetailsCheckedFavorites")
            static let imdbStar = UIImage(named: "imdbStar")
            static let clock = UIImage(named: "Clock")
        }
        enum Color {
            static let componentsColor = UIColor(red: 202, green: 202, blue: 202, alpha: 1)
            static let backgroundViewColor = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
        }
    }
}
