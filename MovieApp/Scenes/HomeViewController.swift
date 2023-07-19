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
    private var titleLabelTopConstraint: NSLayoutConstraint!
    
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
        let moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: moviesCollectionViewLayout)
        moviesCollectionView.numberOfItems(inSection: 2)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(
            MovieCell.self,
            forCellWithReuseIdentifier: Constants.MovieCollectionView.cell
        )
    }()
    
    
    //MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .black
        keyboardDismiss()
        setUpSearchBar()
        setUpCategoryCollectionView()
        setUpTitleLabel()
//        setUpMovieView()
        setUpMovieCollectionView()
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
    
//    private let movieView = MovieView()
//
//    private func setUpMovieView() {
//        view.addSubview(movieView)
//
//        NSLayoutConstraint.activate([
//            movieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            movieView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        movieView.translatesAutoresizingMaskIntoConstraints = false
//    }
    
    private func setUpMovieCollectionView() {
        view.addSubview(moviesCollectionView)
        
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62)
        ])
    }
}

//MARK: - Filter Button
extension HomeViewController: SearchBarDelegate {
    func filterButtonTap() {
        categoryCollectionView.isHidden.toggle()
        
        if !categoryCollectionView.isHidden {
            titleLabelTopConstraint.constant = Constants.TitleLabel.newTopPadding
        } else {
            titleLabelTopConstraint.constant = Constants.TitleLabel.topPadding
        }
        view.layoutIfNeeded()
    }
}

//MARK: - Category Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.CategoryCollectionView.cell,
            for: indexPath) as! CategoryCell
        return cell
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
