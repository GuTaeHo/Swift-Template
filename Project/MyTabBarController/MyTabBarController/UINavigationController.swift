//
//  UINavigationController.swift
//  MyTabBarController
//
//  Created by 구태호 on 2022/11/14.
//

import UIKit

// 이 extension을 작성하면 어느 UINavigationController에서든 왼쪽 스와이프를 통해 이전 뷰 컨트롤러로 돌아갈 수 있음
extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
