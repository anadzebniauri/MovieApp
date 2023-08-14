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
    let duration_mins: Int
    let review_stars: Double
    let images: LandscapeImages
    let release_dates: [DetailsReleaseDates]
    let genres: [Genres]
    let synopsis_long: String
    
    var image: String {
        images.poster.the1.medium.film_image
    }
    var year: String {
        release_dates.first?.release_date ?? "Date"
    }
    var genre: String {
        genres.first?.genre_name ?? "Genre"
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

struct DetailsReleaseDates: Decodable {
    let release_date: String
}

struct Genres: Decodable {
    let genre_name: String
}
