//
//  SceneDelegate.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit
import WidgetKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBar = UITabBarController()
        
        let firstVC = UINavigationController(rootViewController: CategoryHomeViewController())
        firstVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: Constant.SFSymbol.firstTabBarIcon),selectedImage: UIImage(systemName: Constant.SFSymbol.firstTabBarIcon))

        let secondVC = UINavigationController(rootViewController: MyListViewController())
        secondVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: Constant.SFSymbol.secondTabBarIcon),selectedImage: UIImage(systemName: Constant.SFSymbol.secondTabBarIcon))
        
        let thirdVC = UINavigationController(rootViewController: SettingViewController())
        thirdVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: Constant.SFSymbol.thirdTabBarIcon),selectedImage: UIImage(systemName: Constant.SFSymbol.thirdTabBarIcon))
        
        tabBar.viewControllers = [firstVC, secondVC, thirdVC]
        tabBar.tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tabBar.tintColor = UIColor.label
        tabBar.selectedIndex = 1
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
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
        // 앱이 포그라운드에서 백그라운드로 전환될 때 위젯 데이터 업데이트
        WidgetCenter.shared.reloadTimelines(ofKind: "TempiWidget")
    }

    
}

