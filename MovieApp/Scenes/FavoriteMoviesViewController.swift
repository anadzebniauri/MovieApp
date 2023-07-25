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
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = Constants.Title.navigationBarTitle
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let noMovies = NoMovies()

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
        setUpNoMovies()
    }
    
    private func setUpNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.setHeight(62)
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
        titleLabel.setHeight(18)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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

private extension FavoriteMoviesViewController {
    enum Constants {
        enum Title {
            static let navigationBarTitle = "Favorite Movies"
        }
        enum Color {
            static let yellow = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
    }
}
