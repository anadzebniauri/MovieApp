//
//  LoadingViewController.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 01.08.23.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    // MARK: - Properties
    var loadingView: UIView!
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = .black
        setupLoadingView()
        animateLoading()
    }
    
    func setupLoadingView() {
        let loadingSize = Constants.Loader.size
        let loadingOrigin = CGPoint(
            x: (view.frame.width - loadingSize) / 2,
            y: (view.frame.height - loadingSize) / 2
        )
        loadingView = UIView(
            frame: CGRect(origin: loadingOrigin,
                          size: CGSize(
                            width: loadingSize,
                            height: loadingSize)
                         ))
        loadingView.backgroundColor = .clear
        view.addSubview(loadingView)
        
        let imageView = UIImageView(
            frame: CGRect(x: 0, y: 0,
                          width: loadingSize,
                          height: loadingSize
                         ))
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.Image.spinner
        loadingView.addSubview(imageView)
    }
    
    func animateLoading() {
        let imageView = loadingView.subviews.first as? UIImageView
        
        let rotationAnimation = CABasicAnimation(keyPath: Constants.Animation.rotationAnimationKey)
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = .infinity
        imageView?.layer.add(rotationAnimation, forKey: Constants.Animation.rotationAnimation)
        
        let opacityAnimation = CABasicAnimation(keyPath: Constants.Animation.opacityAnimationKey)
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.1
        opacityAnimation.duration = 2.0
        opacityAnimation.repeatCount = .infinity
        imageView?.layer.add(opacityAnimation, forKey: Constants.Animation.opacityAnimation)
    }
    
}

// MARK: - Constants
private extension LoadingViewController {
    enum Constants {
        enum Loader {
            static let size = 128.0
        }
        enum Animation {
            static let rotationAnimationKey = "transform.rotation.z"
            static let rotationAnimation = "rotationAnimation"
            static let opacityAnimationKey = "opacity"
            static let opacityAnimation = "opacityAnimation"
        }
        enum Image {
            static let spinner = UIImage(named: "Spinner")
        }
    }
}
