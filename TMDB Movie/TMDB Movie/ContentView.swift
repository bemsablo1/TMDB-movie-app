//
//  ContentView.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MoviesViewModel()
    @State private var searchText = ""
    @EnvironmentObject var favs: FavoritesManager

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search movies...", text: $searchText, onCommit: {
                    vm.searchMovies(query: searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                List(vm.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRowView(movie: movie)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Popular Movies")
            .onAppear {
                vm.fetchPopularMovies()
            }
        }
    }
}
