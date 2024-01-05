//
//  UIView+.swift
//  MyAlpha
//
//  Created by 구태호 on 1/5/24.
//

import UIKit


extension UIView {
    func display(animated: Bool = true) {
        if isHidden == false {
            return
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.isHidden = false
                self.alpha = 1
            })
        } else {
            self.isHidden = false
            self.alpha = 1
        }
    }
    
    func hidden(animated: Bool = true) {
        if isHidden {
            return
        }
        
        /**
         hidden 의 주체가되는 뷰의 상위 뷰가 UIStackView 라면 애니메이션 시작 시 `즉시 숨김`,
         아니라면 alpha 를 줄인 후, `애니메이션 종료 후 숨김`
         */
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                if self.superview is UIStackView {
                    self.isHidden = true
                }
                self.alpha = 0
            }) { _ in
                if !(self.superview is UIStackView) {
                    self.isHidden = true
                }
            }
        } else {
            self.isHidden = true
            self.alpha = 0
        }
    }
}
