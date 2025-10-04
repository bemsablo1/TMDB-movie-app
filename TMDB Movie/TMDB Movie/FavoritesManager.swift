//
//  FavoritesManager.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: Set<Int>
    private let key = "favorites_tmdb_ids"

    init() {
        if let data = UserDefaults.standard.array(forKey: key) as? [Int] {
            favorites = Set(data)
        } else {
            favorites = []
        }
    }

    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }

    func toggle(id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        save()
    }

    private func save() {
        UserDefaults.standard.set(Array(favorites), forKey: key)
    }
}
