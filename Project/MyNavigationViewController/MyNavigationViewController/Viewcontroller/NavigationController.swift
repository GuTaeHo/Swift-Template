//
//  NavigationController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

class NavigationController: UINavigationController {
    lazy var button = {
        let button = UIButton()
        button.configuration = .filled()
        button.setTitle("네비게이션 컨트롤러\n고정 버튼 테스트", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        addButton()
    }
    
    private func initViewController() {
        if let splashViewController = self.viewController(storyboardName: "Main", viewController: RedViewController().self) {
            self.viewControllers = [splashViewController]
        } else {
            print("최초 뷰 컨트롤러 초기화 오류...")
        }
    }
    
    private func addButton() {
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
