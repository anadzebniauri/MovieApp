//
//  UIFont+Extension.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 08.08.23.
//

import UIKit

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func semiBold(ofSize size: CGFloat) -> UIFont {
        customFont(name: "Montserrat-SemiBold", size: size)
    }
    static func medium(ofSize size: CGFloat) -> UIFont {
        customFont(name: "Montserrat-Medium", size: size)
    }
    static func regular(ofSize size: CGFloat) -> UIFont {
        customFont(name: "Montserrat-Regular", size: size)
    }
    static func bold(ofSize size: CGFloat) -> UIFont {
        customFont(name: "Montserrat-Bold", size: size)
    }
}
