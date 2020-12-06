//
//  SceneDelegate.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        AppDelegate.shared.openStartScreen(window: window)
        window?.makeKeyAndVisible()
    }
}

