//
//  Untitled.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 14.11.2024.
//

import Foundation
import UIKit

class NetworkingManager {
    static let shared = NetworkingManager()
    private let apiKey = "6fdcfd10a965db106e74abe5fd109302"
    
    private let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    private let session = URLSession(configuration: .default)
    
    private init() {}
}

extension NetworkingManager {
    
    // Fetch list of popular movies
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(baseUrl)/movie/popular?api_key=\(apiKey)") else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch movies:", error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let moviesData = try JSONDecoder().decode(Movies.self, from: data)
                DispatchQueue.main.async {
                    completion(moviesData.results)
                }
            } catch {
                print("Failed to decode JSON:", error)
            }
        }
        task.resume()
    }
    
    // Fetch detailed information for a specific movie by movie_id
    func getMovieDetails(movieID: Int, completion: @escaping (MovieDetail?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/movie/\(movieID)?api_key=\(apiKey)") else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch movie details:", error?.localizedDescription ?? "No error description")
                completion(nil)
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(movieDetail)
                }
            } catch {
                print("Failed to decode JSON:", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getMovieCredits(movieID: Int, completion: @escaping ([CastMember]) -> Void) {
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits")
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        guard let url = urlComponents?.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch movie credits:", error ?? "No error description")
                return
            }
            
            do {
                let creditsData = try JSONDecoder().decode(CreditsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(creditsData.cast)
                }
            } catch {
                print("Failed to decode credits JSON:", error)
            }
        }
        task.resume()
    }
    
    func getActorDetails(actorID: Int, completion: @escaping (ActorDetail?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/person/\(actorID)?api_key=\(apiKey)") else { return }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to fetch actor details:", error?.localizedDescription ?? "No error description")
                completion(nil)
                return
            }
            
            do {
                let actorDetail = try JSONDecoder().decode(ActorDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(actorDetail)
                }
            } catch {
                print("Failed to decode actor details JSON:", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    // Load an image from the provided poster path
    func loadImage(posterPath: String, completion: @escaping (UIImage?) -> Void) {
        let fullPath = baseImageUrl + "/" + posterPath.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: fullPath) else {
            print("Invalid URL for image:", fullPath)
            completion(nil)
            return
        }
        
        print("Loading image from URL:", url)  // Print the URL for debugging

        let task = session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to load image:", error?.localizedDescription ?? "No error description")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("Failed to create UIImage from data")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }

}
