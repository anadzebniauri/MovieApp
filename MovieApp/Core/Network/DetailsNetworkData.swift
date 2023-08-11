//
//  DetailsNetworkData.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 11.08.23.
//

import Foundation

struct DetailsNetworkData: Decodable {
    let film_id: Int
    let film_name: String
    let images: LandscapeImages
    
    var image: String {
        images.poster.the1.medium.film_image
    }
}

struct LandscapeImages: Decodable {
    let poster: Still
}

struct Still: Decodable {
    let the1: Still1

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

struct Still1: Decodable {
    let medium: MediumLandscape
}

struct MediumLandscape: Decodable {
    let film_image: String
}
