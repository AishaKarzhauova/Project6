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

        // create window
        window = UIWindow(windowScene: windowScene)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
                
        // Initialize MainViewController with the layout
        let mainViewController = MainViewController(collectionViewLayout: layout)
        
        // wrap MainViewController in UINavigationController
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        // set UINavigationController as source controller
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    // other func stay the same
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
