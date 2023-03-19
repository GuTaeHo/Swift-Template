//
//  CommonButton.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/14.
//

import UIKit
import SnapKit

@IBDesignable
class CommonButton: UIButton {
    
    @IBInspectable
    var text: String? {
        get {
            self.currentTitle
        }
        
        set {
            self.setTitle(newValue, for: .normal) 
        }
    }
    
    @IBInspectable
    /// 텍스트 색상
    /// - note: 지정된 색상 없을 경우 기본색상 적용
    var textColor: UIColor? {
        get {
            if let foregroundColor = configuration?.baseForegroundColor {
                return foregroundColor
            }
            
            return UIColor(r: 230, g: 230, b: 230, a: 1)
        }
        
        set {
            if let newValue = newValue {
                self.configuration?.baseForegroundColor = newValue
            } else {
                self.configuration?.baseForegroundColor = UIColor(r: 230, g: 230, b: 230, a: 1)
            }
        }
    }
    
    @IBInspectable
    /// 버튼 색상
    /// - note: 지정된 색상 없을 경우 기본색상 적용
    var buttonColor: UIColor? {
        get {
            if let foregroundColor = configuration?.baseBackgroundColor {
                return foregroundColor
            }
            
            return UIColor(r: 51, g: 51, b: 51, a: 1)
        }
        
        set {
            if let newValue = newValue {
                self.configuration?.baseBackgroundColor = newValue
            } else {
                self.configuration?.baseBackgroundColor = UIColor(r: 51, g: 51, b: 51, a: 1)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    /// 노치가 있는 디스플레이(X 시리즈) 하단(다음) 버튼 레이아웃 적용
    func changeNextButtonLayout(viewController: UIViewController, isKeyboardShow: Bool = false) {
        if isKeyboardShow {
            self.snp.remakeConstraints {
                $0.height.equalTo(56)
            }
            self.configuration?.contentInsets.bottom = 0
            return
        }
        
        if let bottomSafeAreaHeight = viewController.safeAreaSize(direction: .bottom), bottomSafeAreaHeight != 0 {
            self.snp.remakeConstraints {
                $0.height.equalTo(56 + bottomSafeAreaHeight)
            }
            
            // 하단 인셋 적용
            self.configuration?.contentInsets.bottom = bottomSafeAreaHeight
        } else {
            self.snp.remakeConstraints {
                $0.height.equalTo(56)
            }
        }
    }
}
