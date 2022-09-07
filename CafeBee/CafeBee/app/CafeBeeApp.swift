//
//  CafeBeeApp.swift
//  CafeBee
//
//  Created by 구태호 on 2022/06/23.
//

import SwiftUI

// @main > 앱 진입점 알림
@main
struct CafeBeeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// App > Scene > View
// View가 모여서 Scene(ContentView)을 구성
// Scene이 모여서 App을 구성
// MARK: View == storyboard로 구성하던 UILabel, UIImage 같은 뷰
// MARK: Scene == MainViewController 같은 뷰컨트롤러를 의미(자체적인 수명주기를 가지고 있음)
// MARK: App == Scene(ViewController)이 모여서 하나의 앱을 구성하는것과 같음
