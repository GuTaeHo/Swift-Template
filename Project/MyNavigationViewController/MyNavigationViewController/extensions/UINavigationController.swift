//
//  UINavigationController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/24.
//

import UIKit

extension UINavigationController {
    /// 이전 뷰 컨트롤러 반환
    /// - parameter context: 이전 뷰 컨트롤러 타입
    /// - returns T
    func previousViewController<T>(context: T) -> T? {
        let viewController = viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
        
        guard let viewController = viewController as? T else {
            return nil
        }
        
        return viewController
    }
    
    func sendDataPreviousViewController() {
        print("\(String(describing: viewControllers.last))")
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
    // open 키워드를 통해 모듈 외부에서 메소드 접근 및 서브클래싱(오버라이딩)이 가능한 듯..?
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let count = viewControllers.count
        // 스택에 뷰 컨트롤러가 2개 이상일 때 허용
        if count > 1 {
            return true
        } else {
            return false
        }
    }
}

