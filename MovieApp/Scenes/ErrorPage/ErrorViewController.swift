//
//  ErrorPage.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 31.07.23.
//

import UIKit

final class ErrorViewController: UIViewController {
    
    // MARK: - Properties
    private let errorIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.errorIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.dataText
        label.textColor = .white
        label.font = UIFont.bold(ofSize: Constants.DataLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let internetLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.internetText
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 0
        label.font = UIFont.medium(ofSize: Constants.InternetLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = UIColor.appYellow()
        button.layer.cornerRadius = Constants.refreshButton.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let refreshLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.buttonText
        label.textColor = .black
        label.font = UIFont.semiBold(ofSize: Constants.refreshLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let refreshIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Image.refresh
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - SetUp
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
        // TODO: implement
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

// MARK: - Constants
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
            static let fontSize = 18.0
        }
        enum InternetLabel {
            static let topPadding = 23.0
            static let leadingPadding = 64.0
            static let trailingPadding = -64.0
            static let fontSize = 16.0
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
            static let fontSize = 14.0
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
    }
}
