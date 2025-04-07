//
//  ViewController.swift
//  MyExternalAppReceiver
//
//  Created by 구태호 on 2023/02/01.
//

import UIKit
import Combine

/**
 ## MyExternalAppOpener 프로젝트 참고
 
 **이 앱은 열리는 쪽 입니다**
 
 ## URL Scheme 방식으로 앱 여는 방법 (열리는 쪽)
 1. 프로젝트 > Target > Info > URL Types 에 `시스템이 인식`할 자신의(열릴) 앱의 URL Scheme 을 지정한다.
 2. AppDelegate 만 사용중인 프로젝트일 경우,
    `application(_: UIApplication, open: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool`
    를 구현하면, open 인자로 url 정보가 들어오며 핸들링이 가능하다.
 3. SceneDelegate 를 함께 사용하는 프로젝트의 경우 (이 경우 AppDelegate 에 구현된 open 메소드는 호출되지 않는다),
    `scene(_: UIScene, openURLContexts: Set<UIOpenURLContext>)` 를 구현해준 뒤, 들어오는 url 목록을 핸들링 해주면 된다.
 
 ### URL Types 추가 방법
 
 `Info.plist` 에 아래의 코드 추가
 
 ```xml
 <key>CFBundleURLTypes</key>
 <array>
     <dict>
         <key>CFBundleTypeRole</key>
         <string>Editor</string>
         <key>CFBundleURLName</key>
         <string>com.example.MyExternalAppOpen</string> <!-- 앱의 Bundle ID -->
         <key>CFBundleURLSchemes</key>
         <array>
             <string>myExternalAppReceiver</string> <!-- 앱의 URL 스킴(별칭) -->
         </array>
     </dict>
 </array>
*/
class ViewController: UIViewController {
    @IBOutlet var lbFullURL: UILabel!
    @IBOutlet var lbScheme: UILabel!
    @IBOutlet var lbHost: UILabel!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbAge: UILabel!
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.publisher(for: .receiveDeepLink).sink { [weak self] _ in
            self?.initLayout()
        }.store(in: &cancellables)
        
        initLayout()
    }
    
    func initLayout() {
        if let delegate = UIApplication
            .shared
            .connectedScenes
            .first?
            .delegate as? SceneDelegate,
           let receiveURL = delegate.receiveURL
        {
            let urlComponents = URLComponents(url: receiveURL,
                                              resolvingAgainstBaseURL: true)
            lbFullURL.text = urlComponents?.url?.absoluteString ?? "full url 없음"
            lbScheme.text = urlComponents?.scheme ?? "scheme 없음"
            lbHost.text = urlComponents?.host ?? "host 없음"
            lbName.text = urlComponents?.queryItems?.first(where: { $0.name == "name" })?.value ?? "name 없음"
            lbAge.text = urlComponents?.queryItems?.first(where: { $0.name == "age" })?.value ?? "age 없음"
        }
    }
}

