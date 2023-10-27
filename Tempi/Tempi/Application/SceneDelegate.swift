//
//  SceneDelegate.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        // MARK: - Navigation Controller
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = MyListViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        // MARK: - TabBar Controller
        
        let tabBar = UITabBarController()
        
        let firstVC = UINavigationController(rootViewController: CategoryHomeViewController())
        firstVC.tabBarItem = UITabBarItem(title: "탐색", image: UIImage(systemName: Constant.SFSymbol.firstTabBarIcon),selectedImage: UIImage(systemName: Constant.SFSymbol.firstTabBarIcon))

        let secondVC = UINavigationController(rootViewController: MyListViewController())
        secondVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: Constant.SFSymbol.secondTabBarIcon),selectedImage: UIImage(systemName: Constant.SFSymbol.secondTabBarIcon))
        
//        let thirdVC = UINavigationController(rootViewController: SearchViewController())
//        thirdVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: Constant.SFSymbol.thirdTabBarIcon),selectedImage: UIImage(systemName: Constant.SFSymbol.thirdTabBarIcon))
        
        tabBar.viewControllers = [firstVC, secondVC]
        tabBar.tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tabBar.tintColor = UIColor.label
        
        window?.rootViewController = tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

