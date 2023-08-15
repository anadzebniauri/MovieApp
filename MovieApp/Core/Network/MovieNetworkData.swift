//
//  MovieData.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

struct MovieNetworkData: Decodable {
    let films: [Films]?
}

struct Films: Decodable {
    let film_name: String?
    let images: Images?
    let release_dates: [ReleaseDates]?
    let film_id: Int?
    
    var image: String? {
//        images?.poster?.the1?.medium?.film_image ?? "image_error"
        switch images?.poster {
        case .posterClass(let poster):
            return poster.the1?.medium?.film_image ?? nil
        default:
            return nil
        }
    }
    var year: String {
        release_dates?.first?.release_date ?? "date_error"
    }
    
}

struct Images: Decodable {
    let poster: PosterUnion?
}

enum PosterUnion: Decodable {
    case anythingArray([Any?])
    case posterClass(Poster)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(Poster.self) {
            self = .posterClass(x)
            return
        }
        throw DecodingError.typeMismatch(PosterUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PosterUnion"))
    }
}

struct Poster: Decodable {
    let the1: Poster1?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

struct Poster1: Decodable {
    let medium: Medium?
}

struct Medium: Decodable {
    let film_image: String?
}

struct ReleaseDates: Decodable {
    let release_date: String?
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
