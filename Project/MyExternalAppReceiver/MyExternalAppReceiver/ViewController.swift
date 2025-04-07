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
 
 ## 열리는 쪽의 `Info.plist` 에 아래의 코드가 추가되어야한다
 
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
             <string>myExternalAppOpen</string> <!-- 앱의 URL 스킴(별칭) -->
         </array>
     </dict>
 </array>
*/
class ViewController: UIViewController {
    @IBOutlet var lbFullURL: UILabel!
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
            lbHost.text = urlComponents?.host ?? "host 없음"
            lbName.text = urlComponents?.queryItems?.first(where: { $0.name == "name" })?.value ?? "name 없음"
            lbAge.text = urlComponents?.queryItems?.first(where: { $0.name == "age" })?.value ?? "age 없음"
        }
    }
}

