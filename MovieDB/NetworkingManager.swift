//
//  Untitled.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 14.11.2024.
//

import Foundation
import UIKit

class MovieDBAPI {
    static let shared = MovieDBAPI()
    private let apiKey = "6fdcfd10a965db106e74abe5fd109302"
    
    func fetchPopularMovies(completion: @escaping (Result<Movies, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&page=1"
        guard let url = URL(string: urlString) else { return }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

