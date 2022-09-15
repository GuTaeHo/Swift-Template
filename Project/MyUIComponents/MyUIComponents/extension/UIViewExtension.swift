//
//  UIViewExtension.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/25.
//

import UIKit

extension UIView {
    // @IBInspectable 이 적용된 프로퍼티는 storyboard의 Inspector 창에 나타나며,
    // Swift 코드가 아닌 storyboard에서 바로 객체를 수정할 수 있음
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func addAction(action : @escaping () -> ()) {
        let tap = TapGestureRecognizer(target: self , action: #selector(self.tapGestuer(_:)))
        tap.action = action
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1

        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapGestuer(_ sender: TapGestureRecognizer) {
        sender.action!()
    }
}

class TapGestureRecognizer: UITapGestureRecognizer {
    var action: (() -> ())?
}
