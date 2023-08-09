//
//  Extensions+UIColor.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 17.07.23.
//

import UIKit

extension UIView {
    func stretch(on parentView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            rightAnchor.constraint(equalTo: parentView.rightAnchor),
            leftAnchor.constraint(equalTo: parentView.leftAnchor),
        ])
    }
    
    func stretchOnParent() {
        guard let superview = superview else { return }
        stretch(on: superview)
    }
    
    func setHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    // View should be square at first
    private func becameCircle() {
        layer.cornerRadius = layer.bounds.width / 2
    }
    
    // MARK: - Centring
    func centre(in parentView: UIView) {
        centreVertically(in: parentView)
        centreHorizontally(in: parentView)
    }
    
    private func centreInParent() {
        guard let superview = superview else { return }
        centre(in: superview)
    }
    
    private func centreVertically(in parentView: UIView) {
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
    }
    
    private func centreVerticallyInParent() {
        guard let superview = superview else { return }
        centreVertically(in: superview)
    }
    
    private func centreHorizontally(in parentView: UIView) {
        centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    }
    
    private func centreHorizontallyInParent() {
        guard let superview = superview else { return }
        centreHorizontally(in: superview)
    }
    
    func forAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func make(horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
