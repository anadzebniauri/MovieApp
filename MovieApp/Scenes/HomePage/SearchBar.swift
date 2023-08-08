//
//  SearchBar.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func filterButtonTap(_ searchBar: SearchBar)
    func textFieldDidBeginEditing(_ searchBar: SearchBar)
    func textFieldDidEndEditing(_ searchBar: SearchBar)
}

class SearchBar: UIView {
    
    weak var delegate: SearchBarDelegate?
    
    // MARK: - Properties
    private let searchBar: UITextField = {
        let textField = UITextField()
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
        button.titleLabel?.font = Constants.Font.medium
        button.backgroundColor = .clear
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        setUpSearchBar()
        setUpSearchIconImageView()
        setUpFilterButton()
        setUpCancelButton()
        setUpSearchBarSpaces()
        setUpPlaceholder()
    }
    
    private func setUpSearchBar() {
        addSubview(searchBar)
        searchBar.delegate = self
        
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
        let font = Constants.Font.placeholder
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: Constants.Color.text,
            .font: font ?? .systemFont(ofSize: 40)
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
        delegate?.filterButtonTap(self)
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
}

// MARK: - Text Field Delegate
extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filterButton.isHidden = true
        cancelButton.isHidden = false
        delegate?.textFieldDidBeginEditing(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = searchBar.text, searchText.isEmpty {
            filterButton.isHidden = false
            cancelButton.isHidden = true
            delegate?.textFieldDidEndEditing(self)
        }
    }
}

// MARK: - Constants
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
        enum CancelButton {
            static let text = "Cancel"
            static let leadingPadding = 5.0
            static let trailingPadding = 4.0
            static let topPadding = 4.0
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
        enum Font {
            static let medium = UIFont(name: "Montserrat-Medium", size: 12)
            static let placeholder = UIFont(name: "Montserrat-Medium", size: 16)
            static let regular = UIFont(name: "Montserrat-Regular", size: 14)
        }
    }
}
