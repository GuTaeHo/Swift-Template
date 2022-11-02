//
//  NavigationViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        initViewController()
    }
    
    private func initViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let splashViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController {
            self.viewControllers = [splashViewController]
        } else {
            print("최초 뷰 컨트롤러 초기화 오류...")
        }
    }
}
