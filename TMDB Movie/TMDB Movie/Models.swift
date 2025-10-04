//
//  Models.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import Foundation

// MARK: - Movie Response
struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

// MARK: - Movie
struct Movie: Codable, Identifiable {
    let id: Int
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]?
    let original_language: String
    let original_title: String
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String
    let video: Bool?
    let vote_average: Double
    let vote_count: Int?
}

// MARK: - Movie Details
struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String?
    let runtime: Int?
    let vote_average: Double
    let genres: [Genre]?
    let videos: VideoResponse?
    let credits: CreditsResponse?
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable {
    let key: String
    let type: String
}

struct CreditsResponse: Codable {
    let cast: [Cast]
}

struct Cast: Codable, Identifiable {
    let id: Int
    let name: String
    let profile_path: String?
}
