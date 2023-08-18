//
//  ViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

final class SplashViewController: UIViewController {

    // MARK: - Properties
    private let imdbLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Logo.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.navigateToHomeScreen()
        }
    }
    
    // MARK: - Methods
    private func setUp() {
        view.backgroundColor = .black
        setUpIMDBLogo()
    }
    
    private func navigateToHomeScreen() {
        MainCoordinator(navigationController: navigationController ?? .init()).start()
    }
    
    private func setUpIMDBLogo() {
        view.addSubview(imdbLogo)
        
        NSLayoutConstraint.activate([
            imdbLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imdbLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Constants
private extension SplashViewController {
    enum Constants {
        enum Logo {
            static let image = UIImage(named: "IMDB_Logo")
        }
    }
}
