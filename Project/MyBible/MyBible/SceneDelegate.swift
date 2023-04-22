//
//  SceneDelegate.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // (window 를 부분적으로 구성하고, scene을 윈도우에 붙이기 위해 이 메소드를 사용.)
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // (만약 스토리보드를 사용하고있다면, window 프로퍼티는 자동적으로 scene 에 초기화 및 붙여질 것.)
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // (이 델리게이트는 연결된 scene 또는 session 이 새 것임을 암시하지않음.)
        
        // MARK: Info.plist 대신 소스코드로 직접 UIWindow를 생성하고, viewController 를 표시하고 싶다면 아래 코드 활용
        guard
            let scene = scene as? UIWindowScene
        else { return }
        
        // 1. 획득한 scene으로 window 생성
        let window = UIWindow(windowScene: scene)
        
        // 2. UIWindow에 얹을 네비게이션 컨트롤러 생성
        let navigationController = UINavigationController()
        /// - note: 네비게이션 바 숨김
        navigationController.isNavigationBarHidden = true
        
        // 3. 네비게이션 컨트롤러의 루트 뷰 컨트롤러 생성 및 지정
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController.viewControllers = [viewController]
        }
        
        // 4. window 에 올라갈 루트 뷰 컨트롤러 를 지정함
        window.rootViewController = navigationController
        
        // 5. 생성한 윈도우 저장
        self.window = window
        
        // 6. 윈도우 표시
        window.makeKeyAndVisible()
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

