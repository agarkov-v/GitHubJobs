//
//  AppDelegate.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit
#if DEBUG
import CocoaDebug
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared = (UIApplication.shared.delegate as! AppDelegate)
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        CocoaDebug.enable()
        #endif
        DI.initDependencies()
        openStartScreen(window: window)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
        }
        
    }
    
    func openStartScreen(window: UIWindow?) {
        self.window = window
        guard let window = self.window else { return }
        let rootVC = R.storyboard.jobsList().instantiateInitialViewController()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    } 
}

