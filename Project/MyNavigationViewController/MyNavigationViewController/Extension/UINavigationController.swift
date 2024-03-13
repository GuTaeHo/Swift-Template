//
//  UINavigationController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/24.
//

import UIKit

extension UINavigationController {
    /// 이전 뷰 컨트롤러 반환
    /// - parameter context: 이전 뷰 컨트롤러 메타타입
    /// - returns T
    func previousViewController<T>(context: T.Type) -> T? {
        let viewController = viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
        
        guard let viewController = viewController as? T else {
            return nil
        }
        
        return viewController
    }
    
    /// 현재 뷰 컨트롤러 pop -> 이전 뷰 컨트롤러 -> 원하는 뷰 컨트롤러(생성 후) 이동
    /// - parameter moveTo: 이동 할 뷰 컨트롤러
    func popToRootAndPushViewController(moveTo: UIViewController) {
        self.popToRootViewController(animated: false)
        self.pushViewController(moveTo, animated: true)
    }
}

/// 왼쪽 스와이프 제스처를 통해 이전 컨트롤러로 돌아가는 기능
extension UINavigationController: UIGestureRecognizerDelegate {
    // open 키워드를 통해 모듈 외부에서 메소드 접근 및 오버라이딩이 가능한 것으로 보인다.
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func removePopGestureReognizer() {
        interactivePopGestureRecognizer
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool { viewControllers.count > 1 }
}

