//
//  MoviesViewModel.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    private let apiKey = "f3741874dd346abfde9d15e9a7674bed"

    func fetchPopularMovies() {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
                print("Invalid URL")
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
                    print("No data received")
                    return
                }

                // 4. Decode JSON
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = decoded.results
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


        func searchMovies(query: String) {
            guard !query.isEmpty else {
                fetchPopularMovies()
                return
            }

            guard let urlQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(urlQuery)") else {
                print("Invalid URL")
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
                    print("No data received")
                    return
                }

                // 4. Decode JSON
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = decoded.results
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

}
