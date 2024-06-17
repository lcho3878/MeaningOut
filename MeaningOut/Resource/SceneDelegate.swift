//
//  SceneDelegate.swift
//  MeaningOut
//
//  Created by 이찬호 on 6/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let rootVC: UIViewController
        if User.nickanme != nil {
            rootVC = TabBarController()
        }
        else {
            let onboardVC = OnboardingViewController()
            let nav = UINavigationController(rootViewController: onboardVC)
            rootVC = nav
        }
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }

}

