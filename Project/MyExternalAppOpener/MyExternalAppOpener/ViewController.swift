//
//  ViewController.swift
//  MyExternalAppUrlSchemeOpen
//
//  Created by 구태호 on 2022/10/28.
//

import UIKit


/**
 
 UIApplication.shared.canOpenURL() 와
 UIApplication.shared.open(url, options: [:], completionHandler: nil) 로
 외부 앱을 여는 방법
 
 1. 호출하는 쪽(여는 쪽)의 `Info.plist` 에 아래의 코드가 추가되어야한다
 
 ```xml
 <key>LSApplicationQueriesSchemes</key>
 <array>
     <string>myExternalAppOpen</string>
 </array>
 ```
 
 2. 호출되는 쪽(열리는 쪽)의 `Info.plist` 에 아래의 코드가 추가되어야한다
 
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
 ```
 */

class ViewController: UIViewController {
    @IBOutlet var tfHost: UITextField!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfAge: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openBlossomApp(_ sender: Any) {
        let urlScheme = "blossom://\(tfHost.text ?? "")"
        var components = URLComponents(string: urlScheme)
        components?.queryItems = [
            .init(name: "name", value: tfName.text ?? ""),
            .init(name: "age", value: tfAge.text ?? "")
        ]
        
        if let url = components?.url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("열지 못함")
        }
    }
    
    @IBAction func openMyExternalAppOpenApp(_ sender: Any) {
        let urlScheme = "myExternalAppOpen://\(tfHost.text ?? "")"
        var components = URLComponents(string: urlScheme)
        components?.queryItems = [
            .init(name: "name", value: tfName.text ?? ""),
            .init(name: "age", value: tfAge.text ?? "")
        ]
        
        if let url = components?.url, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("열지 못함")
        }
    }
}

