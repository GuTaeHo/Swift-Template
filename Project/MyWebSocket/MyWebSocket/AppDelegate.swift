//
//  AppDelegate.swift
//  MyWebSocket
//
//  Created by 구태호 on 2022/07/08.
//

import UIKit
import SocketIO

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        socketIOConnetion()
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
    
    func socketIOConnetion() {
#if DEBUG
        let url = "http://test.blossom.bumblebeecrew.com"
#elseif RELEASE
        let url = "http://blossom.bumblebeecrew.com"
#endif
        
        let manager = SocketManager(socketURL: URL(string: url)!, config: [.log(true), .compress])
        let socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            print("@@@ socket connected")
            // socket.emit("chat message", "cocobean has connected")
        }
        
        socket.on("@@@ chat message") {data, ack in
            print(data)
        }
        
        socket.connect()
    }
}

