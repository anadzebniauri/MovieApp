//
//  NavigationBar.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 25.07.23.
//

import UIKit

protocol NavigationBarDelegate: AnyObject {
    func navigationBarHomeButtonTap(_ navigationBar: NavigationBar)
    func navigationBarFavoritesButtonTap(_ navigationBar: NavigationBar)
}

class NavigationBar: UIView {
    
    weak var delegate: NavigationBarDelegate?
    
    // MARK: - Properties
    var config: UIButton.Configuration = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = Constants.Config.contentInsets
        config.imagePadding = Constants.Config.imagePadding
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .clear
        return config
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.HomeButton.cornerRadius
        button.setImage(Constants.Image.selectedHome, for: .selected)
        button.setImage(Constants.Image.home, for: .normal)
        button.backgroundColor = Constants.Color.nonSelected
        button.addTarget(self, action: #selector(navigationBarHomeButtonTap), for: .touchUpInside)
        return button
    }()
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.FavoritesButton.cornerRadius
        button.setImage(Constants.Image.favorites, for: .normal)
        button.setImage(Constants.Image.selectedFavorites, for: .selected)
        button.backgroundColor = Constants.Color.nonSelected
        button.addTarget(self, action: #selector(navigationBarFavoritesButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.ButtonStackView.spacing
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = Constants.ButtonStackView.layoutMargins
        return stackView
    }()
    
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
        backgroundColor = .black
        setUpHomeButtonTitle()
        setUpFavoritesButtonTitle()
        setUpButtonStackView()
    }
    
    private func setUpHomeButtonTitle() {
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.medium(ofSize: Constants.HomeButton.fontSize),
            .foregroundColor: UIColor.white
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.medium(ofSize: Constants.HomeButton.fontSize),
            .foregroundColor: UIColor.black
        ]
        
        let normalAttributedTitle = NSAttributedString(
            string: Constants.HomeButton.text,
            attributes: normalAttributes
        )
        let selectedAttributedTitle = NSAttributedString(
            string: Constants.HomeButton.text,
            attributes: selectedAttributes
        )
        homeButton.setAttributedTitle(normalAttributedTitle, for: .normal)
        homeButton.setAttributedTitle(selectedAttributedTitle, for: .selected)
    }
    
    @objc private func navigationBarHomeButtonTap() {
        guard !homeButton.isSelected else {
            return
        }
        homeButton.isSelected = true
        favoritesButton.isSelected = false
        homeButton.backgroundColor = UIColor.appYellow()
        favoritesButton.backgroundColor = Constants.Color.nonSelected
        delegate?.navigationBarHomeButtonTap(self)
    }
    
    private func setUpFavoritesButtonTitle() {
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.medium(ofSize: Constants.FavoritesButton.fontSize),
            .foregroundColor: UIColor.white
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.medium(ofSize: Constants.FavoritesButton.fontSize),
            .foregroundColor: UIColor.black
        ]
        
        let normalAttributedTitle = NSAttributedString(
            string: Constants.FavoritesButton.text,
            attributes: normalAttributes
        )
        let selectedAttributedTitle = NSAttributedString(
            string: Constants.FavoritesButton.text,
            attributes: selectedAttributes
        )
        favoritesButton.setAttributedTitle(normalAttributedTitle, for: .normal)
        favoritesButton.setAttributedTitle(selectedAttributedTitle, for: .selected)
    }
    
    @objc private func navigationBarFavoritesButtonTap() {
        guard !favoritesButton.isSelected else {
            return
        }
        favoritesButton.isSelected = true
        homeButton.isSelected = false
        favoritesButton.backgroundColor = UIColor.appYellow()
        homeButton.backgroundColor = Constants.Color.nonSelected
        delegate?.navigationBarFavoritesButtonTap(self)
    }

    private func setUpButtonStackView() {
        addSubview(buttonStackView)
        buttonStackView.stretchOnParent()
        buttonStackView.addArrangedSubview(homeButton)
        buttonStackView.addArrangedSubview(favoritesButton)
    }
}

// MARK: - Constants
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
            static let fontSize = 14.0
        }
        enum FavoritesButton {
            static let cornerRadius = 8.0
            static let text = "Favorites"
            static let topPadding = 12.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let bottomPadding = -12.0
            static let fontSize = 14.0
        }
        enum ButtonStackView {
            static let spacing = 16.0
            static let layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        }
        enum Image {
            static let selectedHome = UIImage(named: "SelectedHome")
            static let favorites = UIImage(named: "Favorites")
            static let home = UIImage(named: "Home")
            static let selectedFavorites = UIImage(named: "SelectedFavorites")
        }
        enum Color {
            static let nonSelected = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
        }
    }
}
