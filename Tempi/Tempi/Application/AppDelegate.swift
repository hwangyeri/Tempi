//
//  AppDelegate.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/09/29.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Thread.sleep(forTimeInterval: 1.0)
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // FIXME: Local Notification? 다국어 대응 필요
        
        // 푸시 알림 권한 설정, FCM 등록
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        
        // 메세지 대리자 설정
        Messaging.messaging().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: - UNUserNotificationCenterDelegate (Apple)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%0.2hhx", $0) }.joined()
        print("Apple registration token: ", token)
        
//        Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: - MessagingDelegate (Firebase)
extension AppDelegate: MessagingDelegate {
    
    //토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            print("Firebase registration token: \(token)")
            let dataDict: [String: String] = ["token": token]
            NotificationCenter.default.post(
                name: Notification.Name("FCMToken"),
                object: nil,
                userInfo: dataDict
            )
        } else {
            print("Firebase registration token is nil.")
        }
    }
}
