//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 26.07.23.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let detailsComponentsView = DetailsComponentsView()
    
    private let navigationBar = NavigationBar()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Image.backArrow, for: .normal)
        button.imageView?.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Title.detailsTitle
        label.textColor = .white
        label.font = Constants.Font.semiBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.movieDetailsImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Title.aboutMovie
        label.textColor = .white
        label.font = Constants.Font.semiBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let movieDescription: UILabel = {
        let label = UILabel()
        label.text = Constants.Title.movieDescription
        label.textColor = .white
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.font = Constants.Font.medium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - SetUp
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
        navigationController?.popViewController(animated: false)
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

// MARK: - Constants
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
