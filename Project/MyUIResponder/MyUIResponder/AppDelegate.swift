//
//  AppDelegate.swift
//  MyUIResponder
//
//  Created by 구태호 on 2023/07/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var sharedText: String = ""


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

    // 리스폰더 체인에서 처리되지 않은 이벤트가 있을 때 UIApplication 이 받도록 처리할 수 있다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("UIApplication 이 이벤트를 받음")
    }
}

