//
//  ErrorPage.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 31.07.23.
//

import UIKit

class ErrorViewController: UIViewController {
    
    //MARK: - Properties
    private let errorIcon: UIImageView = {
        let errorIcon = UIImageView()
        errorIcon.image = Constants.Image.errorIcon
        errorIcon.translatesAutoresizingMaskIntoConstraints = false
        return errorIcon
    }()
    
    private let dataLabel: UILabel = {
        let dataLabel = UILabel()
        dataLabel.text = Constants.Text.dataText
        dataLabel.textColor = .white
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        return dataLabel
    }()
    
    private let internetLabel: UILabel = {
        let internetLabel = UILabel()
        internetLabel.text = Constants.Text.internetText
        internetLabel.textColor = .white
        internetLabel.textAlignment = .center
        internetLabel.lineBreakMode = .byTruncatingMiddle
        internetLabel.numberOfLines = 0
        internetLabel.translatesAutoresizingMaskIntoConstraints = false
        return internetLabel
    }()
    
    private let refreshButton: UIButton = {
        let refreshButton = UIButton()
        refreshButton.clipsToBounds = true
        refreshButton.backgroundColor = Constants.Color.buttonColor
        refreshButton.layer.cornerRadius = Constants.refreshButton.cornerRadius
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        return refreshButton
    }()
    
    private let refreshLabel: UILabel = {
        let refreshLabel = UILabel()
        refreshLabel.text = Constants.Text.buttonText
        refreshLabel.textColor = .black
        refreshLabel.translatesAutoresizingMaskIntoConstraints = false
        return refreshLabel
    }()
    
    private let refreshIcon: UIImageView = {
        let refreshIcon = UIImageView()
        refreshIcon.image = Constants.Image.refresh
        refreshIcon.translatesAutoresizingMaskIntoConstraints = false
        return refreshIcon
    }()
    
    //MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    //MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .black
        setUpErrorIcon()
        setUpDataLabel()
        setUpInternetLabel()
        setUpRefreshButton()
        setUpRefreshLabel()
        setUpRefreshIcon()
    }
    
    private func setUpErrorIcon() {
        view.addSubview(errorIcon)
        
        NSLayoutConstraint.activate([
            errorIcon.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.ErrorIcon.topPadding
            ),
            errorIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpDataLabel() {
        view.addSubview(dataLabel)
        
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(
                equalTo: errorIcon.bottomAnchor,
                constant: Constants.DataLabel.topPadding
            ),
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpInternetLabel() {
        view.addSubview(internetLabel)
        
        NSLayoutConstraint.activate([
            internetLabel.topAnchor.constraint(
                equalTo: dataLabel.bottomAnchor,
                constant: Constants.InternetLabel.topPadding
            ),
            internetLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.InternetLabel.leadingPadding
            ),
            internetLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.InternetLabel.trailingPadding
            )
        ])
    }
    
    private func setUpRefreshButton() {
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(
                equalTo: internetLabel.bottomAnchor,
                constant: Constants.refreshButton.topPadding
            ),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        refreshButton.addTarget(self, action: #selector(refreshButtonTap), for: .touchUpInside)
    }
    
    @objc private func refreshButtonTap() {
    }
    
    private func setUpRefreshLabel() {
        refreshButton.addSubview(refreshLabel)
        
        NSLayoutConstraint.activate([
            refreshLabel.topAnchor.constraint(
                equalTo: refreshButton.topAnchor,
                constant: Constants.refreshLabel.topPadding
            ),
            refreshLabel.leadingAnchor.constraint(
                equalTo: refreshButton.leadingAnchor,
                constant: Constants.refreshLabel.leadingPadding
            ),
            refreshLabel.trailingAnchor.constraint(
                equalTo: refreshButton.trailingAnchor,
                constant: Constants.refreshLabel.trailingPadding
            ),
            refreshLabel.bottomAnchor.constraint(
                equalTo: refreshButton.bottomAnchor,
                constant: Constants.refreshLabel.bottomPadding
            )
        ])
    }
    
    private func setUpRefreshIcon() {
        refreshButton.addSubview(refreshIcon)
        
        NSLayoutConstraint.activate([
            refreshIcon.topAnchor.constraint(
                equalTo: refreshButton.topAnchor,
                constant: Constants.refreshIcon.topPadding
            ),
            refreshIcon.leadingAnchor.constraint(
                equalTo: refreshLabel.trailingAnchor,
                constant: Constants.refreshIcon.leadingPadding
            ),
            refreshIcon.trailingAnchor.constraint(
                equalTo: refreshButton.trailingAnchor,
                constant: Constants.refreshIcon.trailingPadding
            ),
            refreshIcon.bottomAnchor.constraint(
                equalTo: refreshButton.bottomAnchor,
                constant: Constants.refreshIcon.bottomPadding
            )
        ])
    }
}

//MARK: - Constants
private extension ErrorViewController {
    enum Constants {
        enum Text {
            static let dataText = "Data can’t be loaded"
            static let internetText = "internet connection or some other server error"
            static let buttonText = "Refresh"
        }
        enum ErrorIcon {
            static let topPadding = 229.0
        }
        enum DataLabel {
            static let topPadding = 28.0
        }
        enum InternetLabel {
            static let topPadding = 23.0
            static let leadingPadding = 64.0
            static let trailingPadding = -64.0
        }
        enum refreshButton {
            static let cornerRadius = 16.0
            static let topPadding = 110.0
        }
        enum refreshLabel {
            static let topPadding = 14.0
            static let leadingPadding = 30.0
            static let trailingPadding = -48.0
            static let bottomPadding = -14.0
        }
        enum refreshIcon {
            static let topPadding = 14.0
            static let leadingPadding = 2.0
            static let trailingPadding = -30.0
            static let bottomPadding = -14.0
        }
        enum Image {
            static let errorIcon = UIImage(named: "Caution")
            static let refresh = UIImage(named: "Refresh")
        }
        enum Color {
            static let buttonColor = UIColor(red: 245, green: 197, blue: 24, alpha: 1)
        }
    }
}
