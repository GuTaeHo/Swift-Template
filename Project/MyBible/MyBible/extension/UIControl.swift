//
//  UIControl.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

// TODO: 분석하기
extension UIControl {
    // UIControl 을 인자로 받는 클로저의 별칭 선언
    public typealias UIControlTargetClosure = (UIControl) -> ()
    
    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIControlTargetClosure? {
        // 정의된 closure 가 있는 경우에 closure 반환
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.targetClosure,
                                     UIControlClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        // 정의된 클로저가 있는 경우에 실행
        targetClosure(self)
    }
    
    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }
}
