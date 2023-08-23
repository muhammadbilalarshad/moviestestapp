//
//  Utility.swift
//  MoviesTestApp
//
//  Created by ZONE-1 on 24/08/2023.
//

import Foundation
import UIKit

class Utility {
    static func getCurrentViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return nil
        }
        
        var currentViewController = keyWindow.rootViewController
        
        while let presentedViewController = currentViewController?.presentedViewController {
            currentViewController = presentedViewController
        }
        
        return currentViewController
    }
    
    static func showErrorWith(message: String){
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        getCurrentViewController()?.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
    }
}
