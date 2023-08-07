//
//  FavoriteMoviesViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 22.07.23.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    //MARK: - Properties
    private let navigationBar = NavigationBar()
    private let noMovies = NoMovies()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = Constants.Title.navigationBarTitle
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = Constants.Font.semiBold
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var favoriteMoviesCollectionView: UICollectionView = {
        let favoriteMoviesCollectionView = UICollectionViewFlowLayout()
        favoriteMoviesCollectionView.scrollDirection = .vertical
        favoriteMoviesCollectionView.minimumInteritemSpacing = 16
        favoriteMoviesCollectionView.minimumLineSpacing = 16
        
        let moviesCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: favoriteMoviesCollectionView
        )
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        moviesCollectionView.register(
            MovieCell.self,
            forCellWithReuseIdentifier: Constants.FavoriteMoviesCollectionView.cell
        )
        moviesCollectionView.backgroundColor = .clear
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return moviesCollectionView
    }()

    //MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .black
        setUpNavigationBar()
        setUpTitleLabel()
        setUpFavoriteMoviesCollectionView()
//        setUpNoMovies()
    }
    
    private func setUpNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.delegate = self
        navigationBar.favoritesButton.isSelected = true
        navigationBar.favoritesButton.backgroundColor = Constants.Color.yellow
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.Title.topPadding
            ),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpFavoriteMoviesCollectionView() {
        view.addSubview(favoriteMoviesCollectionView)
        
        NSLayoutConstraint.activate([
            favoriteMoviesCollectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.FavoriteMoviesCollectionView.topPadding
            ),
            favoriteMoviesCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.FavoriteMoviesCollectionView.leadingPadding
            ),
            favoriteMoviesCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.FavoriteMoviesCollectionView.trailingPadding
            ),
            favoriteMoviesCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Constants.FavoriteMoviesCollectionView.bottomPadding
            )
        ])
    }
    
    private func setUpNoMovies() {
        view.addSubview(noMovies)
        
        NSLayoutConstraint.activate([
            noMovies.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noMovies.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        noMovies.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Navigation Bar Buttons
extension FavoriteMoviesViewController: NavigationBarDelegate {
    func homeButtonTap() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    func favoritesButtonTap() {
        let favoriteMoviesViewController = FavoriteMoviesViewController()
        navigationController?.pushViewController(favoriteMoviesViewController, animated: false)
    }
}

//MARK: - Favorite Movies Collection View
extension FavoriteMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.FavoriteMoviesCollectionView.cell,
            for: indexPath) as! MovieCell
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is MovieCell {
            let detailsViewController = DetailsViewController()
            navigationController?.pushViewController(detailsViewController, animated: false)
        }
    }
}

//MARK: - Favorites Collection View Delegate Flow Layout
extension FavoriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - Constants.FavoriteMoviesCollectionView.leadingPadding - Constants.FavoriteMoviesCollectionView.trailingPadding - Constants.FavoriteMoviesCollectionView.spacing) / 2
        return CGSize(width: width, height: width * 1.64)
    }
}

//MARK: - Constants
private extension FavoriteMoviesViewController {
    enum Constants {
        enum Title {
            static let navigationBarTitle = "Favorite Movies"
            static let topPadding = 11.0
        }
        enum FavoriteMoviesCollectionView {
            static let cell = "MovieCell"
            static let topPadding = 11.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let bottomPadding = -62.0
            static let spacing = 16.0
        }
        enum Color {
            static let yellow = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
        enum Font {
            static let semiBold = UIFont(name: "Montserrat-SemiBold", size: 16)
        }
    }
}
