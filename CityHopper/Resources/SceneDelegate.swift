//
//  SceneDelegate.swift
//  CityHopper
//
//  Created by chiawei wen on 3/15/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = LocationRequestViewController()
        window?.makeKeyAndVisible()
    }
}

