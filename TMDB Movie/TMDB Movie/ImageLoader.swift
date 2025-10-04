//
//  ImageLoader.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(path: String?) {
        guard let path = path else { return }
        let urlString = "https://image.tmdb.org/t/p/w200\(path)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$image) // No need to store in `cancellable`
    }


    func cancel() {
        cancellable?.cancel()
    }
}
