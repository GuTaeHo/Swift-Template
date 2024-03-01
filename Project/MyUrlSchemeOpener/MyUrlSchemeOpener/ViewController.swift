//
//  ViewController.swift
//  MyUrlSchemeOpener
//
//  Created by 구태호 on 12/19/23.
//

import UIKit

/**
 URL Scheme 방식으로 앱 여는 방법 (여는 쪽)
 1. `info.plist` 에 `Queried URL Schemes` 속성을 추가한다.
 2. 열고 싶은 앱의 URL Scheme 을 item 의 value 에 입력한다.
 3. `UIApplication.shared.canOpenUrl(_: URL)` 함수를 통해 앱을 열 수 있는지 검사한다.
 4. `UIApplication.shared.open(_: URL)` 함수로 앱을 연다.
 */

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonHandler(_ sender: UIButton) {
        guard let url = URL(string: "myurlschemereceiver://cocobeans/account/login?type=original&mode=") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

