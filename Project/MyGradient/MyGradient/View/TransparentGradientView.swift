//
//  TransparentGradientView.swift
//  MyGradient
//
//  Created by 구태호 on 2023/06/30.
//

import UIKit


@IBDesignable
class TransparentGradientView: UIView {
    /// 그래디언트 방향 (기본: .bottom)
    private var _isBottomDirection = true
    /// 그래디언트 색상 (기본: 128, 128, 128)
    private var _gradientColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1.0)
    
    @IBInspectable
    var isBottomDirection: Bool {
        get {
            return _isBottomDirection
        }
        
        set {
            _isBottomDirection = newValue
        }
    }
    
    @IBInspectable
    var gradientColor: UIColor {
        get {
            return _gradientColor
        }
        
        set {
            _gradientColor = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isBottomDirection {
            transparentGradient(startColor: _gradientColor, gradientDirection: .bottom)
        } else {
            transparentGradient(startColor: _gradientColor, gradientDirection: .top)
        }
    }
}
 
