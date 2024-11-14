//
//  MovieDetail.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 14.11.2024.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let releaseDate: String
    let genres: [Genre]
    let voteAverage: Double
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case genres
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
