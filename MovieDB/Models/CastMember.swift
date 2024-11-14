//
//  CastMember.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 14.11.2024.
//

import Foundation

struct CreditsResponse: Codable {
    let cast: [CastMember]
}

struct CastMember: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
