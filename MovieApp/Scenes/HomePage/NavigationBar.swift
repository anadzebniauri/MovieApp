//
//  NavigationBar.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 25.07.23.
//

import UIKit

protocol NavigationBarDelegate: AnyObject {
    func homeButtonTap()
    func favoritesButtonTap()
}

class NavigationBar: UIView {
    
    weak var delegate: NavigationBarDelegate?
    
    //MARK: - Properties
    var config: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = Constants.Config.contentInsets
        config.imagePadding = Constants.Config.imagePadding
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .clear
        return config
    }()
    
    lazy var homeButton: UIButton = {
        let homeButton = UIButton(configuration: config)
        homeButton.clipsToBounds = true
        homeButton.layer.cornerRadius = Constants.HomeButton.cornerRadius
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.setImage(Constants.Image.selectedHome, for: .selected)
        homeButton.setImage(Constants.Image.home, for: .normal)
        homeButton.setTitle(Constants.HomeButton.text, for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.setTitleColor(.black, for: .selected)
        homeButton.backgroundColor = Constants.Color.grey
        homeButton.addTarget(self, action: #selector(homeButtonTap), for: .touchUpInside)
        return homeButton
    }()
    
    lazy var favoritesButton: UIButton = {
        let favoritesButton = UIButton(configuration: config)
        favoritesButton.clipsToBounds = true
        favoritesButton.layer.cornerRadius = Constants.FavoritesButton.cornerRadius
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.setImage(Constants.Image.favorites, for: .normal)
        favoritesButton.setImage(Constants.Image.selectedFavorites, for: .selected)
        favoritesButton.setTitle(Constants.FavoritesButton.text, for: .normal)
        favoritesButton.setTitleColor(.white, for: .normal)
        favoritesButton.setTitleColor(.black, for: .selected)
        favoritesButton.backgroundColor = Constants.Color.grey
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTap), for: .touchUpInside)
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
        backgroundColor = .black
        setUpHomeButton()
        setUpFavoritesButton()
    }
    
    private func setUpHomeButton() {
        addSubview(homeButton)
        
        NSLayoutConstraint.activate([
            homeButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.HomeButton.topPadding
            ),
            homeButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.HomeButton.leadingPadding
            ),
            homeButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: Constants.HomeButton.bottomPadding
            ),
        ])
        homeButton.setWidth(UIScreen.main.bounds.width/2 - 24)
    }
    
    @objc private func homeButtonTap() {
        if !homeButton.isSelected {
            homeButton.isSelected = true
            favoritesButton.isSelected = false
            homeButton.backgroundColor = Constants.Color.yellow
            favoritesButton.backgroundColor = Constants.Color.grey
            delegate?.homeButtonTap()
        }
    }
    
    private func setUpFavoritesButton() {
        addSubview(favoritesButton)
        
        NSLayoutConstraint.activate([
            favoritesButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.FavoritesButton.topPadding
            ),
            favoritesButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.FavoritesButton.trailingPadding
            ),
            favoritesButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: Constants.FavoritesButton.bottomPadding
            ),
            favoritesButton.leadingAnchor.constraint(
                equalTo: homeButton.trailingAnchor,
                constant: Constants.FavoritesButton.leadingPadding
            )
        ])
    }
    
    @objc private func favoritesButtonTap() {
        if !favoritesButton.isSelected {
            favoritesButton.isSelected = true
            homeButton.isSelected = false
            favoritesButton.backgroundColor = Constants.Color.yellow
            homeButton.backgroundColor = Constants.Color.grey
            delegate?.favoritesButtonTap()
        }
    }
}

//MARK: - Constants
private extension NavigationBar {
    enum Constants {
        enum Config {
            static let contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
            static let imagePadding = 3.0
        }
        enum HomeButton {
            static let cornerRadius = 8.0
            static let text = "Home"
            static let topPadding = 12.0
            static let leadingPadding = 16.0
            static let bottomPadding = -12.0
        }
        enum FavoritesButton {
            static let cornerRadius = 8.0
            static let text = "Favorites"
            static let topPadding = 12.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let bottomPadding = -12.0
        }
        enum Image {
            static let selectedHome = UIImage(named: "SelectedHome")
            static let favorites = UIImage(named: "Favorites")
            static let home = UIImage(named: "Home")
            static let selectedFavorites = UIImage(named: "SelectedFavorites")
        }
        enum Color {
            static let yellow = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
            static let grey = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
        }
    }
}
