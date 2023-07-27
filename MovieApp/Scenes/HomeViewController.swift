//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private let searchBar = SearchBar()
    private let navigationBar = NavigationBar()
    private var titleLabelTopConstraint: NSLayoutConstraint!
    private var movieCollectionViewTopConstraint: NSLayoutConstraint!
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: Constants.CategoryCollectionView.cell
        )
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.clipsToBounds = true
        categoryCollectionView.isHidden = true
        categoryCollectionView.allowsMultipleSelection = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return categoryCollectionView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = Constants.TitleLabel.text
        titleLabel.textColor = Constants.Color.titleLabel
        titleLabel.setHeight(Constants.TitleLabel.height)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let moviesCollectionViewLayout = UICollectionViewFlowLayout()
        moviesCollectionViewLayout.scrollDirection = .vertical
        moviesCollectionViewLayout.minimumInteritemSpacing = 16
        moviesCollectionViewLayout.minimumLineSpacing = 16
        
        let numberOfItemsPerRow: CGFloat = Constants.MovieCollectionView.numberOfItemsPerRow
        let moviesCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: moviesCollectionViewLayout
        )
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(
            MovieCell.self,
            forCellWithReuseIdentifier: Constants.MovieCollectionView.cell
        )
        moviesCollectionView.backgroundColor = .clear
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        let totalSpacingWidth = moviesCollectionViewLayout.minimumInteritemSpacing * (numberOfItemsPerRow - 1)
        let availableWidth = UIScreen.main.bounds.width - totalSpacingWidth
        let itemWidth = availableWidth / numberOfItemsPerRow - 16
        moviesCollectionViewLayout.itemSize = CGSize(
            width: itemWidth,
            height: Constants.MovieCollectionView.cellHeight
        )
        return moviesCollectionView
    }()
    
    //MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    //MARK: - SetUp
    private func setUp() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        keyboardDismiss()
        setUpSearchBar()
        setUpCategoryCollectionView()
        setUpTitleLabel()
        setUpMovieCollectionView()
        setUpNavigationBar()
    }
    
    private func keyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setUpSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.SearchBar.topPadding
            ),
            searchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.SearchBar.leadingPadding
            ),
            searchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.SearchBar.trailingPadding
            )
        ])
        searchBar.setHeight(Constants.SearchBar.height)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpCategoryCollectionView() {
        view.addSubview(categoryCollectionView)
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: Constants.CategoryCollectionView.topPadding
            ),
            categoryCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.CategoryCollectionView.leadingPadding
            ),
            categoryCollectionView.trailingAnchor.constraint(
                greaterThanOrEqualTo: view.trailingAnchor
            ),
            categoryCollectionView.heightAnchor.constraint(
                equalToConstant: Constants.CategoryCollectionView.height
            )
        ])
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(
            equalTo: searchBar.bottomAnchor,
            constant: Constants.TitleLabel.topPadding
        )
        titleLabelTopConstraint.isActive = true
        
        titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: Constants.TitleLabel.leadingPadding
        ).isActive = true
    }

    private func setUpMovieCollectionView() {
        view.addSubview(moviesCollectionView)
        
        movieCollectionViewTopConstraint = moviesCollectionView.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: Constants.MovieCollectionView.topPadding
        )
        movieCollectionViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            moviesCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.MovieCollectionView.leadingPadding
            ),
            moviesCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.MovieCollectionView.trailingPadding
            ),
            moviesCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Constants.MovieCollectionView.bottomPadding
            )
        ])
    }
    
    private func setUpNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.delegate = self
        navigationBar.homeButton.isSelected = true
        navigationBar.homeButton.backgroundColor = Constants.Color.yellow
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: moviesCollectionView.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Filter Button
extension HomeViewController: SearchBarDelegate {
    func filterButtonTap() {
        categoryCollectionView.isHidden.toggle()
        
        if !categoryCollectionView.isHidden {
            titleLabelTopConstraint.constant = Constants.TitleLabel.newTopPadding
            movieCollectionViewTopConstraint.constant = Constants.MovieCollectionView.topPadding
        } else {
            titleLabelTopConstraint.constant = Constants.TitleLabel.topPadding
            movieCollectionViewTopConstraint.constant = Constants.MovieCollectionView.topPadding
        }
        view.layoutIfNeeded()
    }
}

//MARK: - Movie Cell Delegate
extension HomeViewController: MovieCellDelegate {
    func movieViewTap() {
        let detailsViewController = DetailsViewController()
        navigationController?.pushViewController(detailsViewController, animated: false)
    }
}

//MARK: - Navigation Bar Buttons
extension HomeViewController: NavigationBarDelegate {
    func homeButtonTap() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    func favoritesButtonTap() {
        let favoriteMoviesViewController = FavoriteMoviesViewController()
        navigationController?.pushViewController(favoriteMoviesViewController, animated: false)
    }
}

//MARK: - Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return 10
        } else if collectionView == moviesCollectionView {
            return 10
        }
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
        let categoryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.CategoryCollectionView.cell,
            for: indexPath) as! CategoryCell
        return categoryCell
        } else if collectionView == moviesCollectionView {
            let movieCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.MovieCollectionView.cell,
                for: indexPath) as! MovieCell
            movieCell.delegate = self
            return movieCell
        }
        return UICollectionViewCell()
    }
}

//MARK: - Constants
private extension HomeViewController {
    enum Constants {
        enum SearchBar {
            static let topPadding = 19.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let cornerRadius = 25.0
            static let placeholderText = "Search"
            static let height = 36.0
        }
        enum CategoryCollectionView {
            static let topPadding = 8.0
            static let leadingPadding = 20.0
            static let cell = "CategoryCell"
            static let height = 40.0
        }
        enum MovieCollectionView {
            static let cell = "MovieCell"
            static let topPadding = 16.0
            static let newTopPadding = 56.0
            static let numberOfItemsPerRow = 2.0
            static let spacing = 16.0
            static let cellHeight = 270.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let bottomPadding = -62.0
        }
        enum TitleLabel {
            static let text = "Movies"
            static let height = 18.0
            static let topPadding = 22.0
            static let newTopPadding = 62.0
            static let leadingPadding = 16.0
        }
        enum Color {
            static let titleLabel = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
            static let homeButton = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
            static let favoritesButton = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
            static let yellow = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
    }
}


//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//    }
//}
//struct ViewController_Preview: PreviewProvider {
//    static var previews: some View {
//         ViewControllerRepresentable()
//    }
//}
//#endif
