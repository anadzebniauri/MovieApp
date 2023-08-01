//
//  ViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - Properties
    private let imdbLogo: UIImageView = {
        let imdbLogo = UIImageView()
        imdbLogo.image = Constants.Logo.image
        imdbLogo.translatesAutoresizingMaskIntoConstraints = false
        return imdbLogo
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpImdbLogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.navigateToHomeScreen()
        }
    }
    
    //MARK: - Methods
    private func navigateToHomeScreen() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    private func setUpImdbLogo() {
        view.addSubview(imdbLogo)
        
        NSLayoutConstraint.activate([
            imdbLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imdbLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

//MARK: - Constants
private extension SplashViewController {
    enum Constants {
        enum Logo {
            static let image = UIImage(named: "IMDB_Logo")
        }
    }
}
