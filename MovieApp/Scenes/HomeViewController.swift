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
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return categoryCollectionView
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
}

//MARK: - Filter Button
extension HomeViewController: SearchBarDelegate {
    func filterButtonTap() {
        categoryCollectionView.isHidden.toggle()
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
