//
//  MovieData.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

struct MovieNetworkData: Codable {
    let films: [Films]
}

struct Films: Codable {
    let film_name: String
    let images: Images
    let release_dates: [ReleaseDates]
    
    var image: String {
        images.poster.the1.medium.film_image
    }
}

struct Images: Codable {
    let poster: Poster
}

struct Poster: Codable {
    let the1: Poster1

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

struct Poster1: Codable {
    let medium: Medium
}

struct Medium: Codable {
    let film_image: String
}

struct ReleaseDates: Codable {
    let release_date: String
}

//$.films.[0].release_dates.[0].release_date
