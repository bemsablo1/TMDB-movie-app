//
//  MovieRowView.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.


import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    @StateObject private var loader = ImageLoader()
    @EnvironmentObject var favs: FavoritesManager

    var body: some View {
        HStack(alignment: .top) {
            Group {
                if let img = loader.image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                        .overlay(Text("No Image").font(.caption))
                }
            }
            .frame(width: 100, height: 150)
            .clipped()
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(2)
                    Spacer()
                    Button(action: { favs.toggle(id: movie.id) }) {
                        Image(systemName: favs.isFavorite(id: movie.id) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }

                HStack {
                    Text(String(format: "⭐️ %.1f", movie.vote_average))
                        .font(.subheadline)
                    if let rd = movie.release_date, !rd.isEmpty {
                        Text("• \(rd.prefix(4))")
                            .font(.subheadline)
                    }
                }

                Text(movie.overview ?? "")
                    .font(.caption)
                    .lineLimit(4)
            }
        }
        .onAppear { loader.load(path: movie.poster_path) }
        .onDisappear { loader.cancel() }
    }
}

