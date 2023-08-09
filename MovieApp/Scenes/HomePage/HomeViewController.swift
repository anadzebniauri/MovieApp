//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let searchBar = SearchBar()
    private let navigationBar = NavigationBar()
    private var titleLabelTopConstraint: NSLayoutConstraint!
    private var movieCollectionViewTopConstraint: NSLayoutConstraint!
    private var searchBarHeightConstraint: NSLayoutConstraint!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.TitleLabel.text
        label.textColor = UIColor.appYellow()
        label.setHeight(Constants.TitleLabel.height)
        label.font = UIFont.semiBold(ofSize: Constants.TitleLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumInteritemSpacing = Constants.MovieCollectionView.spacing
        collectionViewLayout.minimumLineSpacing = Constants.MovieCollectionView.spacing
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - SetUp
    private func setUp() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        keyboardDismiss()
        setUpSearchBar()
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
        tapGesture.cancelsTouchesInView = false
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
        searchBarHeightConstraint = searchBar.heightAnchor.constraint(
            equalToConstant: Constants.SearchBar.height)
        searchBarHeightConstraint.isActive = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
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
        navigationBar.homeButton.backgroundColor = UIColor.appYellow()
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Search Bar Delegate
extension HomeViewController: SearchBarDelegate {
    func searchBarCategoryCollectionHidden(_ searchBar: SearchBar) {
        titleLabelTopConstraint.constant = Constants.TitleLabel.topPadding
        movieCollectionViewTopConstraint.constant = Constants.MovieCollectionView.topPadding
        searchBarHeightConstraint.constant = Constants.SearchBar.height
    }
    func searchBarCategoryCollectionShown(_ searchBar: SearchBar) {
        titleLabelTopConstraint.constant = Constants.TitleLabel.topPadding
        movieCollectionViewTopConstraint.constant = Constants.MovieCollectionView.topPadding
        searchBarHeightConstraint.constant = Constants.SearchBar.newHeight
    }
}

// MARK: - Movie Cell Delegate
extension HomeViewController: MovieCellDelegate {
    func movieViewTap(_ movieCell: MovieCell) {
        let detailsViewController = DetailsViewController()
        navigationController?.pushViewController(detailsViewController, animated: false)
    }
}

// MARK: - Navigation Bar Buttons
extension HomeViewController: NavigationBarDelegate {
    func navigationBarHomeButtonTap(_ navigationBar: NavigationBar) {
        navigationController?.pushViewController(HomeViewController(), animated: false)
    }
    
    func navigationBarFavoritesButtonTap(_ navigationBar: NavigationBar) {
        navigationController?.pushViewController(FavoriteMoviesViewController(), animated: false)
    }
}

// MARK: - Collection View DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let movieCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.MovieCollectionView.cell,
                for: indexPath) as! MovieCell
            movieCell.delegate = self
            return movieCell
    }
}

// MARK: - Collection View Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is MovieCell {
            let detailsViewController = DetailsViewController()
            navigationController?.pushViewController(detailsViewController, animated: false)
        }
    }
}

// MARK: Collection View Delegate Flow Layout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width
                     - Constants.MovieCollectionView.leadingPadding
                     - Constants.MovieCollectionView.trailingPadding
                     - Constants.MovieCollectionView.spacing) / 2
        return CGSize(width: width, height: width * Constants.MovieCollectionView.aspectRatio)
    }
}

// MARK: - Constants
private extension HomeViewController {
    enum Constants {
        enum SearchBar {
            static let topPadding = 19.0
            static let leadingPadding = 16.0
            static let trailingPadding = -16.0
            static let cornerRadius = 25.0
            static let placeholderText = "Search"
            static let height = 36.0
            static let newHeight = 65.0
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
            static let aspectRatio = 1.64
        }
        enum TitleLabel {
            static let text = "Movies"
            static let height = 18.0
            static let topPadding = 22.0
            static let leadingPadding = 16.0
            static let fontSize = 18.0
        }
        enum Color {
            static let favoritesButton = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
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
