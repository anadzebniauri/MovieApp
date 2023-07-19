//
//  SearchBar.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func filterButtonTap()
}

class SearchBar: UIView {
    
    weak var delegate: SearchBarDelegate?
    
    //MARK: - Properties
    private let searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.backgroundColor = Constants.Color.searchBar
        searchBar.textColor = Constants.Color.textColor
        searchBar.setHeight(Constants.SearchBar.height)
        searchBar.textAlignment = .left
        searchBar.layer.cornerRadius = Constants.SearchBar.cornerRadius
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let filterButton: UIButton = {
        let filterButton = UIButton()
        filterButton.setImage(Constants.Image.filterIcon, for: .normal)
        filterButton.setImage(Constants.Image.filterIconClicked, for: .selected)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        return filterButton
    }()
    
    private let searchIconImageView: UIImageView = {
       let searchIconImageView = UIImageView()
        searchIconImageView.image = Constants.Image.searchIcon
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return searchIconImageView
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
        setUpSearchBar()
        setUpSearchIconImageView()
        setUpFilterButton()
        setUpSearchBarSpaces()
        setUpPlaceholder()
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
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: Constants.Color.textColor
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
        delegate?.filterButtonTap()
    }
}

//MARK: - Constants
private extension SearchBar {
    enum Constants {
        enum SearchBar {
            static let cornerRadius = 22.0
            static let trailingPadding = -44.0
            static let placeholderText = "Search"
            static let height = 36.0
            static let searchBarSpace = CGRect(x: 0, y: 0, width: 44, height: 18)
            static let imageWidth = 14.0
            static let imageHeight = 14.0
        }
        enum FilterButton {
            static let leadingPadding = 8.0
        }
        enum SearchIconImageView {
            static let topPadding = 10.0
            static let bottomPadding = -10.0
            static let leadingPadding = 24.0
        }
        enum Color {
            static let searchBar = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
            static let textColor = UIColor(red: 165, green: 165, blue: 165, alpha: 1)
        }
        enum Image {
            static let searchIcon = UIImage(named: "searchIcon")
            static let filterIcon = UIImage(named: "filterIcon")
            static let filterIconClicked = UIImage(named: "filterIconClicked")
        }
    }
}
