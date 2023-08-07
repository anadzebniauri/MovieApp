//
//  CategoryCell.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 18.07.23.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.clipsToBounds = true
        categoryLabel.text = Constants.CategoryLabel.text
        categoryLabel.textColor = .white
        categoryLabel.font = Constants.Font.medium
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()
    
    //<MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpCategoryCellConstraints()
        setUpCategoryLabelConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func setUp() {
        clipsToBounds = true
        selectedBackgroundView = .none
        backgroundColor = .clear
        layer.cornerRadius = Constants.CategoryLabel.cornerRadius
        layer.borderWidth = Constants.CategoryLabel.borderWidth
        layer.borderColor = Constants.Color.borderColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = isSelectedCategoryCell ? UIColor.clear.cgColor : Constants.Color.borderColor
    }
    
    var isSelectedCategoryCell: Bool = false {
        didSet {
            updateSelectedCell()
        }
    }
    
    private func updateSelectedCell() {
        if isSelectedCategoryCell {
            backgroundColor = Constants.Color.filledButtonColor
            layer.borderWidth = 0
            categoryLabel.textColor = .black
        } else {
            backgroundColor = .clear
            layer.borderWidth = Constants.CategoryLabel.borderWidth
            layer.borderColor = Constants.Color.borderColor
            categoryLabel.textColor = .white
        }
    }
    
    private func setUpCategoryLabelConstraints() {
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.CategoryLabel.topPadding
            ),
            categoryLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.CategoryLabel.leadingPadding
            ),
            categoryLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: trailingAnchor,
                constant: Constants.CategoryLabel.trailingPadding
            ),
            categoryLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: Constants.CategoryLabel.bottomPadding
            )
        ])
    }

    private func setUpCategoryCellConstraints() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - Constants
private extension CategoryCell {
    enum Constants {
        enum CategoryLabel {
            static let cornerRadius = 15.0
            static let text = "drama"
            static let borderWidth = 1.0
            static let topPadding = 4.0
            static let leadingPadding = 12.0
            static let trailingPadding = -12.0
            static let bottomPadding = -4.0
        }
        enum Color {
            static let borderColor = CGColor(red: 234, green: 234, blue: 234, alpha: 1)
            static let textColor = UIColor(red: 234, green: 234, blue: 234, alpha: 1)
            static let filledButtonColor = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
        enum Font {
            static let medium = UIFont(name: "Montserrat-Medium", size: 15)
        }
    }
}
