//
//  Webview.swift
//  TMDB Movie app
//
//  Created by Piyush Tiwari on 04/10/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        return WKWebView(frame: .zero, configuration: config)
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
