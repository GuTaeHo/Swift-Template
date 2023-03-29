//
//  UINavigationController.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/26.
//

import UIKit


extension UINavigationController {
    /// - note: isNavigationBarHidden 의 값을 true 로 설정하면 네비게이션 바가 보이지 않음
}

/// 왼쪽 스와이프 제스처로 이전 뷰 컨트롤러로 돌아가는 기능
extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let count = viewControllers.count
        // 스택에 뷰 컨트롤러가 2개 이상 일 때 뒤로가기 허용
        if count > 1 {
            return true
        } else {
            return false
        }
    }
}
