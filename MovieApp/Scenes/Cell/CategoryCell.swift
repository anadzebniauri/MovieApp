//
//  CategoryCell.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 18.07.23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var categoryButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12)
        config.baseBackgroundColor = .clear
        let categoryButton = UIButton(configuration: config)
        categoryButton.layer.borderWidth = Constants.CategoryButton.borderWidth
        categoryButton.layer.cornerRadius = Constants.CategoryButton.cornerRadius
        categoryButton.layer.borderColor = Constants.Color.borderColor
        categoryButton.setTitle(Constants.CategoryButton.text, for: .normal)
        categoryButton.setTitleColor(.white, for: .normal)
        categoryButton.setTitleColor(.black, for: .selected)
        categoryButton.addTarget(self, action: #selector(categoryButtonTap), for: .touchUpInside)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.clipsToBounds = true
        return categoryButton
    }()
    
    //<MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        selectedBackgroundView = .none
        backgroundColor = .clear
        setUpCategoryCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func setUpCategoryCell() {
        addSubview(categoryButton)
        
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func categoryButtonTap() {
        categoryButton.isSelected.toggle()
        
        if categoryButton.isSelected {
            categoryButton.backgroundColor = Constants.Color.filledButtonColor
            categoryButton.layer.borderColor = .none
        } else {
            categoryButton.backgroundColor = .clear
            categoryButton.layer.borderColor = Constants.Color.borderColor
        }
    }
}

//MARK: - Constants
private extension CategoryCell {
    enum Constants {
        enum CategoryButton {
            static let height = 21.0
            static let cornerRadius = 15.0
            static let text = "drama"
            static let borderWidth = 1.0
        }
        enum Color {
            static let borderColor = CGColor(red: 234, green: 234, blue: 234, alpha: 1)
            static let textColor = UIColor(red: 234, green: 234, blue: 234, alpha: 1)
            static let filledButtonColor = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
    }
}
