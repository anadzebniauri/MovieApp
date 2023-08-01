//
//  NoMovies.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 25.07.23.
//

import UIKit

class NoMovies: UIView {
    
    //MARK: - Properties
    private let noMoviesTitle: UILabel = {
       let noMoviesTitle = UILabel()
        noMoviesTitle.text = Constants.Title.noMovies
        noMoviesTitle.textColor = Constants.Color.noMoviesColor
        noMoviesTitle.textAlignment = .center
        noMoviesTitle.font = Constants.Font.text
        noMoviesTitle.translatesAutoresizingMaskIntoConstraints = false
        return noMoviesTitle
    }()
    
    private let noMoviesIcon: UIImageView = {
       let noMoviesIcon = UIImageView()
        noMoviesIcon.image = Constants.Image.noMovies
        noMoviesIcon.translatesAutoresizingMaskIntoConstraints = false
        return noMoviesIcon
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
        setUpNoMoviesIcon()
        setUpNoMoviesTitle()
    }
    
    private func setUpNoMoviesIcon() {
        addSubview(noMoviesIcon)
        
        NSLayoutConstraint.activate([
            noMoviesIcon.topAnchor.constraint(equalTo: topAnchor),
            noMoviesIcon.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setUpNoMoviesTitle() {
        addSubview(noMoviesTitle)
        
        NSLayoutConstraint.activate([
            noMoviesTitle.topAnchor.constraint(
                equalTo: noMoviesIcon.bottomAnchor,
                constant: Constants.Title.topPadding
            ),
            noMoviesTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            noMoviesTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - Constants
private extension NoMovies {
    enum Constants {
        enum Title {
            static let noMovies = "No movies added yet"
            static let topPadding = 25.0
        }
        enum Image {
            static let noMovies = UIImage(named: "No Results")
        }
        enum Color {
            static let noMoviesColor = UIColor(red: 93, green: 93, blue: 93, alpha: 1)
        }
        enum Font {
            static let text = UIFont.boldSystemFont(ofSize: 16)
        }
    }
}
