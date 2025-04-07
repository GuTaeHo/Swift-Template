//
//  ViewController.swift
//  MyExternalAppOpener
//
//  Created by 구태호 on 2022/10/28.
//

import UIKit


/**
 ## MyExternalAppReceiverer 프로젝트 참고
 
 **이 앱은 보내는(여는) 쪽 입니다**
 
 ## URL Scheme 방식으로 앱 여는 방법 (여는 쪽)
 
 1. `info.plist` 에 `Queried URL Schemes` 속성을 추가한다.
 2. 열고 싶은 앱의 URL Scheme 을 item 의 value 에 입력한다.
 3. `UIApplication.shared.canOpenUrl(_: URL)` 함수를 통해 앱을 열 수 있는지 검사한다.
 4. `UIApplication.shared.open(_: URL)` 함수로 앱을 연다.
 
 
 ### Queried URL Schemes 추가 방법
 
 `Info.plist` 에 아래의 코드 추가
 
 ```xml
 <key>LSApplicationQueriesSchemes</key>
 <array>
     <string>myExternalAppReceiver</string>
 </array>
 ```
 
 **작성된 URL Scheme (myExternalAppReceiver)** 은 열리는 쪽에 등록된 URL Scheme 과 동일해야한다.
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
    
    @IBAction func openMyExternalAppOpenApp(_ sender: Any) {
        let urlScheme = "myExternalAppReceiver://\(tfHost.text ?? "")"
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

