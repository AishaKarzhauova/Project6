//
//  ActorDetail.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 14.11.2024.
//

import Foundation

// ActorDetail model
struct ActorDetail: Codable {
    let name: String
    let birthday: String?
    let deathday: String?
    let biography: String
    let placeOfBirth: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name, birthday, biography, deathday
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
}

