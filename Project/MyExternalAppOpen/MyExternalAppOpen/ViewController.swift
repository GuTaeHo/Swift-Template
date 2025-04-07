//
//  ViewController.swift
//  MyExternalAppOpen
//
//  Created by 구태호 on 2023/02/01.
//

import UIKit
import Combine

/**
 MyExternalAppUrlSchemeOpen 프로젝트 참고
 
 현재 앱은 열리는 쪽의 앱임
*/
class ViewController: UIViewController {
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
            lbHost.text = urlComponents?.host ?? "host 없음"
            lbName.text = urlComponents?.queryItems?.first(where: { $0.name == "name" })?.value ?? "name 없음"
            lbAge.text = urlComponents?.queryItems?.first(where: { $0.name == "age" })?.value ?? "age 없음"
        }
    }
}

