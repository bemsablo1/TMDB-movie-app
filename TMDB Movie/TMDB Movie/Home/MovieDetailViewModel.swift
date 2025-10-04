//
//  MovieDetailViewModel.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var details: MovieDetails?
    @Published var teaserKey: String?
    @Published var cast: [Cast] = []

    private let apiKey = "f3741874dd346abfde9d15e9a7674bed"

//    https://api.themoviedb.org/3/movie/3?api_key=f3741874dd346abfde9d15e9a7674bed
    
    func fetchDetails(for movieId: Int) {
        fetchMovieDetails(id: movieId)
        fetchMovieVideo(id: movieId)
        }

    private func fetchMovieDetails(id: Int) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)") else {
            print("Invalid URL for movie ID: \(id)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // 1. Handle networking error
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }

            // 2. Check HTTP response status
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("HTTP error: \(httpResponse.statusCode)")
                return
            }

            // 3. Handle missing data
            guard let data = data else {
                print("No data received for movie ID: \(id)")
                return
            }

            // 4. Decode JSON
            do {
                let decoded = try JSONDecoder().decode(MovieDetails.self, from: data)
                DispatchQueue.main.async {
                    self.details = decoded
//                    self.trailerKey = decoded.videos?.results.first(where: { $0.type == "Trailer" })?.key
                    self.cast = decoded.credits?.cast ?? []
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            }
        }

        task.resume()
    }
    


    private func fetchMovieVideo(id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(apiKey)") else {
            print("Invalid URL for movie ID: \(id)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle networking error
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            // Check HTTP response
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("HTTP error: \(httpResponse.statusCode)")
                return
            }
            
            // Ensure data exists
            guard let data = data else {
                print("No data received for movie ID: \(id)")
                return
            }
            
            do {
                // Parse JSON manually
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    
                    // Pick first YouTube video
                    if let video = results.first(where: { ($0["site"] as? String) == "YouTube" }),
                       let key = video["key"] as? String {
                        DispatchQueue.main.async {
                            print("Video Key: \(key)")
                            // Pass to your UI player
                            self.teaserKey = key
                        }
                    } else {
                        print("No YouTube video found for movie ID: \(id)")
                    }
                    
                } else {
                    print("JSON parsing error")
                }
            } catch {
                print("Serialization error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }


}
