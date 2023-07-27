//
//  DetailsView.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 27.07.23.
//

import UIKit

class DetailsView: UIView {

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
        clipsToBounds = true
        backgroundColor = Constants.Color.backgroundViewColor
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Constants.backgroundView.cornerRadius
    }
}

//MARK: - Constants
private extension DetailsView {
    enum Constants {
        enum backgroundView {
            static let cornerRadius = 15.0
        }
        enum Color {
            static let backgroundViewColor = UIColor(red: 28, green: 28, blue: 28, alpha: 1)
        }
    }
}
