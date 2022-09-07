//
//  CocobeanView.swift
//  MyIBInspectableIBDesignable
//
//  Created by 구태호 on 2022/06/16.
//

import UIKit

// @IBDesignable 이 적용되면 InterfaceBuilder가 즉시 커스텀 뷰를 업데이트하며,
// storyboard 에서 실시간으로 렌더링되는것을 볼 수 있음
// 소스코드로 구성된 CustomView 일 경우에도 어노테이션을 적용하면 storyboard에서 볼 수 있음
@IBDesignable
class CocobeanView: UIView {
    
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
}
