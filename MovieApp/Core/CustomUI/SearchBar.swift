//
//  SearchBar.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func searchBarCategoryCollectionHidden(_ searchBar: SearchBar)
    func searchBarCategoryCollectionShown(_ searchBar: SearchBar)
}

final class SearchBar: UIView {
    
    weak var delegate: SearchBarDelegate?
    
    // MARK: - Properties
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var searchBar: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = Constants.Color.searchBar
        textField.textColor = Constants.Color.text
        textField.setHeight(Constants.SearchBar.height)
        textField.textAlignment = .left
        textField.layer.cornerRadius = Constants.SearchBar.cornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Image.filterIcon, for: .normal)
        button.setImage(Constants.Image.filterIconClicked, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchIconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Constants.Image.searchIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.CancelButton.text, for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.medium(ofSize: Constants.CancelButton.fontSize)
        button.backgroundColor = .clear
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var selectedIndex:IndexPath?
//
//    private let categoryList: [GenreModel] = [
//        GenreModel(title: "Now Showing"),
//        GenreModel(title: "Coming Soon")
//    ]
    
    private let categoryList = ["Now Showing", "Coming Soon"]
    
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
        setUpSearchBar()
        setUpSearchIconImageView()
        setUpFilterButton()
        setUpCancelButton()
        setUpSearchBarSpaces()
        setUpPlaceholder()
        setUpCategoryCollectionView()
    }
    
    private func setUpSearchBar() {
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.SearchBar.trailingPadding
            )
        ])
    }
    
    private func setUpSearchIconImageView() {
        searchBar.addSubview(searchIconImageView)
        
        NSLayoutConstraint.activate([
            searchIconImageView.topAnchor.constraint(
                equalTo: searchBar.topAnchor,
                constant: Constants.SearchIconImageView.topPadding
            ),
            searchIconImageView.leadingAnchor.constraint(
                equalTo: searchBar.leadingAnchor,
                constant: Constants.SearchIconImageView.leadingPadding
            ),
            searchIconImageView.bottomAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: Constants.SearchIconImageView.bottomPadding
            )
        ])
    }
    
    private func setUpSearchBarSpaces() {
        searchBar.leftView = UIView(frame: Constants.SearchBar.searchBarSpace)
        searchBar.leftViewMode = .always
    }
    
    private func setUpPlaceholder() {
        let paragraphStyle = NSMutableParagraphStyle()
        let font = UIFont.medium(ofSize: Constants.SearchBar.placeholderFontSize)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: Constants.Color.text,
            .font: font
        ]
        let attributedPlaceholder = NSAttributedString(
            string: Constants.SearchBar.placeholderText,
            attributes: attributes
        )
        searchBar.attributedPlaceholder = attributedPlaceholder
    }
    
    private func setUpFilterButton() {
        addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: topAnchor),
            filterButton.leadingAnchor.constraint(
                equalTo: searchBar.trailingAnchor,
                constant: Constants.FilterButton.leadingPadding
            ),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        filterButton.addTarget(self, action: #selector(filterButtonTap), for: .touchUpInside)
    }
    
    @objc private func filterButtonTap() {
        filterButton.isSelected.toggle()
        categoryCollectionView.isHidden.toggle()
        
        if categoryCollectionView.isHidden {
            delegate?.searchBarCategoryCollectionHidden(self)
        } else {
            delegate?.searchBarCategoryCollectionShown(self)
        }
        layoutIfNeeded()
    }
    
    private func setUpCancelButton() {
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.CancelButton.topPadding
            ),
            cancelButton.leadingAnchor.constraint(
                equalTo: searchBar.trailingAnchor,
                constant: Constants.CancelButton.leadingPadding
            ),
            cancelButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.CancelButton.trailingPadding
            ),
        ])
        cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTap() {
        cancelButton.isSelected.toggle()
        searchBar.text = ""
        cancelButton.isHidden = true
        filterButton.isHidden = false
    }
    
    private func setUpCategoryCollectionView() {
        addSubview(categoryCollectionView)
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: Constants.CategoryCollectionView.topPadding
            ),
            categoryCollectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.CategoryCollectionView.leadingPadding
            ),
            categoryCollectionView.trailingAnchor.constraint(
                greaterThanOrEqualTo: trailingAnchor
            ),
            categoryCollectionView.heightAnchor.constraint(
                equalToConstant: Constants.CategoryCollectionView.height
            )
        ])
    }
}

// MARK: - Text Field Delegate
extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filterButton.isHidden = true
        cancelButton.isHidden = false
        
        if filterButton.isSelected {
            filterButton.isSelected = false
            categoryCollectionView.isHidden = true
            delegate?.searchBarCategoryCollectionHidden(self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = searchBar.text, searchText.isEmpty {
            filterButton.isHidden = false
            cancelButton.isHidden = true
        }
    }
}

// MARK: - Collection View DataSource
extension SearchBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.CategoryCollectionView.cell,
            for: indexPath) as! CategoryCell

        let category = categoryList[indexPath.row]
        categoryCell.fillCategoryLabel(with: category)
        
        if selectedIndex == nil {
            categoryCell.isSelectedCategoryCell = indexPath.row == 0
        } else {
            categoryCell.isSelectedCategoryCell = indexPath == selectedIndex
        }
        
        return categoryCell
    }
}

// MARK: Collection View Delegate
extension SearchBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is CategoryCell {
            
            if indexPath != selectedIndex {
                selectedIndex = indexPath
                collectionView.reloadData()
            }
        }
    }
}

// MARK: Collection View Delegate Flow Layout
extension SearchBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.CategoryCollectionView.cell, for: indexPath) as! CategoryCell
        let category = categoryList[indexPath.row]
        categoryCell.fillCategoryLabel(with: category)
        categoryCell.layoutIfNeeded()
        let cellSize = categoryCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return cellSize
    }
}

// MARK: - Constants
private extension SearchBar {
    enum Constants {
        enum SearchBar {
            static let cornerRadius = 18.0
            static let trailingPadding = -44.0
            static let placeholderText = "Search"
            static let height = 36.0
            static let searchBarSpace = CGRect(x: 0, y: 0, width: 44, height: 18)
            static let imageWidth = 14.0
            static let imageHeight = 14.0
            static let placeholderFontSize = 16.0
        }
        enum FilterButton {
            static let leadingPadding = 8.0
        }
        enum SearchIconImageView {
            static let topPadding = 10.0
            static let bottomPadding = -10.0
            static let leadingPadding = 24.0
        }
        enum CancelButton {
            static let text = "Cancel"
            static let leadingPadding = 5.0
            static let trailingPadding = 4.0
            static let topPadding = 4.0
            static let fontSize = 12.0
        }
        enum CategoryCollectionView {
            static let topPadding = 8.0
            static let leadingPadding = 4.0
            static let cell = "CategoryCell"
            static let height = 27.0
        }
        enum Color {
            static let searchBar = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
            static let text = UIColor(red: 165, green: 165, blue: 165, alpha: 1)
        }
        enum Image {
            static let searchIcon = UIImage(named: "searchIcon")
            static let filterIcon = UIImage(named: "filterIcon")
            static let filterIconClicked = UIImage(named: "filterIconClicked")
        }
    }
}
