//
//  NavigationController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        initViewController()
    }
    
    private func initViewController() {
        if let splashViewController = self.viewController(storyboardName: "Main", viewController: RedViewController().self) {
            self.viewControllers = [splashViewController]
        } else {
            print("최초 뷰 컨트롤러 초기화 오류...")
        }
    }
}
