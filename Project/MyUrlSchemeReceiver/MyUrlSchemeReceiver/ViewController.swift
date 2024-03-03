//
//  ViewController.swift
//  MyUrlSchemeReceiver
//
//  Created by 구태호 on 12/19/23.
//

import UIKit
import Combine

/**
 URL Scheme 방식으로 앱 여는 방법 (열리는 쪽)
 1. 프로젝트 > Target > Info > URL Types 에 `시스템이 인식`할 자신의(열릴) 앱의 URL Scheme 을 지정한다.
 2. AppDelegate 만 사용중인 프로젝트일 경우,
    `application(_: UIApplication, open: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool`
    를 구현하면, open 인자로 url 정보가 들어오며 핸들링이 가능하다.
 3. SceneDelegate 를 함께 사용하는 프로젝트의 경우 (이 경우 AppDelegate 에 구현된 open 메소드는 호출되지 않는다),
    `scene(_: UIScene, openURLContexts: Set<UIOpenURLContext>)` 를 구현해준 뒤, 들어오는 url 목록을 핸들링 해주면 된다.
 4.
 */

class ViewController: UIViewController {
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.publisher(for: NSNotification.Name(rawValue: "arrivedUrl")).sink { notification in
            if let url = notification.userInfo?["url"] as? URL {
                print("url absoluteString: " + url.absoluteString)
                print("url scheme: " + (url.scheme ?? ""))
                print("url host: " + (url.host() ?? ""))
                print("url path: " + url.path())
                print("url pathComponents: \(url.pathComponents)")
                print("url query: \(url.query() ?? .init())")
                let urlQueryItem = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems?.compactMap { (name: $0.name, value: $0.value) }
                print("url queryItem: \(urlQueryItem ?? .init())")
            }
        }.store(in: &cancellable)
    }
}

