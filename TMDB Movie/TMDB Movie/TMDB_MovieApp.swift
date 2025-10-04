//
//  TMDB_MovieApp.swift
//  TMDB Movie
//
//  Created by Piyush Tiwari on 04/10/25.
//

import SwiftUI

@main
struct TMDB_MovieApp: App {
    @StateObject private var favs = FavoritesManager()
    
    init() {
            UIWindow.appearance().overrideUserInterfaceStyle = .light
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favs)
        }
    }
}
