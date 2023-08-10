//
//  MovieData.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

struct MovieNetworkData: Codable {
    let films: [MovieData]
    
//    enum CodingKeys: String, CodingKey {
//        case movieData = "films"
//    }
}

struct MovieData: Codable {
    let film_name: String
}
