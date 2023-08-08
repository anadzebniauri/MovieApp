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
    
    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "MyLovely-CustomFont", size: size)
    }
    
    mdmskks
    
}
