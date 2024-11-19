//
//  SceneDelegate.swift
//  MovieDB
//
//  Created by Aisha Karzhauova on 31.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Configure global navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white // Set background to white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // Set title color
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false // Prevent transparency

        // Create the main window
        window = UIWindow(windowScene: windowScene)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
                
        // Initialize MainViewController with the layout
        let mainViewController = MainViewController(collectionViewLayout: layout)
        
        // Wrap MainViewController in UINavigationController
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        // Set UINavigationController as the root controller
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
