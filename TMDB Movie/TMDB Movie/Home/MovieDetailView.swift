////
////  MovieDetailView.swift
////  TMDB Movie app
////
////  Created by Piyush Tiwari on 04/10/25.
////
//
//import SwiftUI
//
//struct MovieDetailView: View {
//    let movie: Movie
//    @StateObject private var vm = MovieDetailViewModel()
//    @EnvironmentObject var favs: FavoritesManager
//
//    private let apiKey = "f3741874dd346abfde9d15e9a7674bed"
//    
////    https://api.themoviedb.org/3/movie/617126/videos?api_key=f3741874dd346abfde9d15e9a7674bed
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//
//                // Trailer
//                if let trailerKey = vm.details?.id {
//                    WebView(url: URL(string: "https://api.themoviedb.org/3/movie/\(trailerKey)/videos?api_key=\(apiKey)")!)
//                        .frame(height: 200)
//                        .cornerRadius(10)
//                } else {
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(height: 200)
//                        .overlay(Text("No Trailer"))
//                        .cornerRadius(10)
//                }
//
//                // Title + Favorite
//                HStack {
//                    Text(vm.details?.title ?? movie.title)
//                        .font(.title2)
//                        .bold()
//                    Spacer()
//                    Button(action: { favs.toggle(id: movie.id) }) {
//                        Image(systemName: favs.isFavorite(id: movie.id) ? "heart.fill" : "heart")
//                            .foregroundColor(.red)
//                            .font(.title2)
//                    }
//                }
//
//                // Rating + Duration
//                HStack {
//                    Text(" \(String(format: "%.1f", vm.details?.vote_average ?? movie.vote_average))")
//                    if let runtime = vm.details?.runtime {
//                        Text("• \(runtime) min")
//                    }
//                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//
//                // Genres
//                if let genres = vm.details?.genres {
//                    Text("Genres: \(genres.map { $0.name }.joined(separator: ", "))")
//                        .font(.subheadline)
//                }
//
//                // Overview
//                if let overview = vm.details?.overview ?? movie.overview {
//                    Text(overview)
//                        .font(.body)
//                        .padding(.top, 8)
//                }
//
//                // Cast
//                if !vm.cast.isEmpty {
//                    Text("Cast")
//                        .font(.headline)
//                        .padding(.top, 12)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(vm.cast.prefix(10)) { actor in
//                                VStack {
//                                    if let profile = actor.profile_path,
//                                       let url = URL(string: "https://image.tmdb.org/t/p/w200\(profile)") {
//                                        AsyncImage(url: url) { image in
//                                            image.resizable().scaledToFill()
//                                        } placeholder: {
//                                            Color.gray.opacity(0.3)
//                                        }
//                                        .frame(width: 80, height: 100)
//                                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                                    } else {
//                                        Rectangle()
//                                            .fill(Color.gray.opacity(0.3))
//                                            .frame(width: 80, height: 100)
//                                    }
//                                    Text(actor.name)
//                                        .font(.caption)
//                                        .frame(width: 80)
//                                        .lineLimit(1)
//                                }
//                            }
//                        }
//                    }
//                }
//
//            }
//            .padding()
//        }
//        .navigationTitle(movie.title)
//        .navigationBarTitleDisplayMode(.inline)
//        .onAppear {
//            vm.fetchDetails(for: movie.id)
//        }
//    }
//}







//
//  MovieDetailView.swift
//  TMDB Movie app
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @StateObject private var vm = MovieDetailViewModel()
    @EnvironmentObject var favs: FavoritesManager

    private let apiKey = "f3741874dd346abfde9d15e9a7674bed"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Trailer
                if let trailerKey = vm.teaserKey {
                    WebView(url: URL(string: "https://www.youtube.com/embed/\(trailerKey)?playsinline=1")!)
                        .frame(height: 200)
                        .cornerRadius(10)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay(Text("No Trailer"))
                        .cornerRadius(10)
                }

                // Title + Favorite
                HStack {
                    Text(vm.details?.title ?? movie.title)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button(action: { favs.toggle(id: movie.id) }) {
                        Image(systemName: favs.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }

                // Rating + Duration
                HStack {
                    Text(" \(String(format: "%.1f", vm.details?.vote_average ?? movie.vote_average))")
                    if let runtime = vm.details?.runtime {
                        Text("• \(runtime) min")
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                // Genres
                if let genres = vm.details?.genres {
                    Text("Genres: \(genres.map { $0.name }.joined(separator: ", "))")
                        .font(.subheadline)
                }

                // Overview
                if let overview = vm.details?.overview ?? movie.overview {
                    Text(overview)
                        .font(.body)
                        .padding(.top, 8)
                }

                // Cast
                if !vm.cast.isEmpty {
                    Text("Cast")
                        .font(.headline)
                        .padding(.top, 12)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(vm.cast.prefix(10)) { actor in
                                VStack {
                                    if let profile = actor.profile_path,
                                       let url = URL(string: "https://image.tmdb.org/t/p/w200\(profile)") {
                                        AsyncImage(url: url) { image in
                                            image.resizable().scaledToFill()
                                        } placeholder: {
                                            Color.gray.opacity(0.3)
                                        }
                                        .frame(width: 80, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } else {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 80, height: 100)
                                    }
                                    Text(actor.name)
                                        .font(.caption)
                                        .frame(width: 80)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                }

            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.fetchDetails(for: movie.id)
        }
    }
}
