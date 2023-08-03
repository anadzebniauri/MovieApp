//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 26.07.23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let detailsComponentsView = DetailsComponentsView()
    
    private let navigationBar = NavigationBar()
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(Constants.Image.backArrow, for: .normal)
        backButton.imageView?.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.text = Constants.Title.detailsTitle
        detailsLabel.textColor = .white
        detailsLabel.font = Constants.Font.semiBold
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailsLabel
    }()
    
    private let movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.image = Constants.Image.movieDetailsImage
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    private let aboutMovieLabel: UILabel = {
        let aboutMovieLabel = UILabel()
        aboutMovieLabel.text = Constants.Title.aboutMovie
        aboutMovieLabel.textColor = .white
        aboutMovieLabel.font = Constants.Font.semiBold
        aboutMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutMovieLabel
    }()

    private let movieDescription: UILabel = {
        let movieTextView = UILabel()
        movieTextView.text = Constants.Title.movieDescription
        movieTextView.textColor = .white
        movieTextView.textAlignment = .left
        movieTextView.lineBreakMode = .byClipping
        movieTextView.numberOfLines = 0
        movieTextView.font = Constants.Font.medium
        movieTextView.translatesAutoresizingMaskIntoConstraints = false
        return movieTextView
    }()

    //MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    //MARK: - SetUp
    private func setUp() {
        setUpBackButton()
        setUpDetailsTitle()
        setUpScrollView()
        setUpMovieImage()
        setUpDetailsComponentsView()
        setUpAboutMovieLabel()
        setUpMovieTextView()
    }
    
    private func setUpScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: detailsLabel.bottomAnchor,
                constant: Constants.ScrollView.topPadding
            ),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpBackButton() {
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.BackButton.topPadding
            ),
            backButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.BackButton.leadingPadding
            )
        ])
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
    }

    @objc private func backButtonTap() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    private func setUpDetailsTitle() {
        view.addSubview(detailsLabel)
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.DetailsTitle.topPadding
            ),
            detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpMovieImage() {
        scrollView.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func setUpDetailsComponentsView() {
        scrollView.addSubview(detailsComponentsView)
        
        NSLayoutConstraint.activate([
            detailsComponentsView.topAnchor.constraint(
                equalTo: movieImage.bottomAnchor,
                constant: Constants.DetailsComponentsView.topPadding
            ),
            detailsComponentsView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.DetailsComponentsView.leadingPadding
            ),
            detailsComponentsView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.DetailsComponentsView.trailingPadding
            )
        ])
        detailsComponentsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpAboutMovieLabel() {
        scrollView.addSubview(aboutMovieLabel)
        
        NSLayoutConstraint.activate([
            aboutMovieLabel.topAnchor.constraint(
                equalTo: detailsComponentsView.bottomAnchor,
                constant: Constants.AboutMovieLabel.topPadding
            ),
            aboutMovieLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Constants.AboutMovieLabel.leadingPadding
            )
        ])
    }
    
    private func setUpMovieTextView() {
        scrollView.addSubview(movieDescription)
        
        NSLayoutConstraint.activate([
            movieDescription.topAnchor.constraint(
                equalTo: aboutMovieLabel.bottomAnchor,
                constant: Constants.MovieDescription.topPadding
            ),
            movieDescription.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Constants.MovieDescription.leadingPadding
            ),
            movieDescription.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: Constants.MovieDescription.trailingPadding
            ),
            movieDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            movieDescription.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor,
                constant: Constants.MovieDescription.width
            )
        ])
    }
}

//MARK: - Constants
private extension DetailsViewController {
    enum Constants {
        enum Title {
            static let navigationBarTitle = "Favorite Movies"
            static let detailsTitle = "Details"
            static let aboutMovie = "About movie"
            static let movieDescription = "Thirteen-year-old fledgling writer Briony Tallis irrevocably changes the course of several lives when she accuses her older sister's lover of a crime he did not commit."
        }
        enum ScrollView {
            static let topPadding = 8.0
        }
        enum BackButton {
            static let topPadding = 8.0
            static let leadingPadding = 16.0
        }
        enum DetailsTitle {
            static let topPadding = 8.0
        }
        enum DetailsComponentsView {
            static let topPadding = 26.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
        }
        enum AboutMovieLabel {
            static let topPadding = 26.0
            static let leadingPadding = 16.0
        }
        enum MovieDescription {
            static let topPadding = 8.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let width = -32.0
        }
        enum Color {
            static let yellow = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
        enum Image {
            static let backArrow = UIImage(named: "back arrow")
            static let movieDetailsImage = UIImage(named: "movieDetailsImage")
        }
        enum Font {
            static let semiBold = UIFont(name: "Montserrat-SemiBold", size: 16)
            static let medium = UIFont(name: "Montserrat-Medium", size: 14)
        }
    }
}
