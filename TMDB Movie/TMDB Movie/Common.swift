//
//  Common.swift
//  TMDB Movie
//
//  Created by Piyush Tiwari on 04/10/25.
//

import UIKit


class CommonAlertPopUp {
    static func showAlert(title: String, message: String, in viewController: UIViewController? = nil) {
        
        let vc: UIViewController? = viewController ?? {
        
            let scenes = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
            
            
            let window = scenes.first?.windows.first(where: { $0.isKeyWindow })
            
            return window?.rootViewController
        }()

        guard let topVC = vc else { return }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            topVC.present(alert, animated: true)
        }
    }
}
