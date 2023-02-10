//
//  ViewController.swift
//  MyExternalAppOpen
//
//  Created by 구태호 on 2023/02/01.
//

import UIKit

/**
 외부 앱 열기 예제
 1. MyExternalAppOpen.xcodeproj > Target > URL Types 열기
 2. 열고 싶은 앱의 Identifier(ex -> com.example.MyExternalAppOpen) 와 URL Schemes (ex -> myExternalApp) 작성 후 + 버튼으로 추가
 3. 방금 작성한 URL Schemes 를 UIApplication.shared.open(string: String) 메소드로 열기
 */
// MARK: 브라우저 주소창에 스키마명:// (ex >> myExternalApp://) 입력 시 현재 앱 실행됨
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func appOpen(_ sender: Any) {
        let appURL = URL(string: "daeguro://daeguro?project=DELIVERY")!
        let webURL = URL(string: "http://naver.com")!
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
}

