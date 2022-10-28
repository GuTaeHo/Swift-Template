//
//  UIView.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/28.
//

import UIKit

extension UIView {
    func addAction(isAnimation: Bool = false, action: @escaping () -> ()) {
        let tap = TapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        tap.isAnimation = isAnimation
        tap.action = action
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapGesture(_ sender: TapGestureRecognizer) {
        sender.action!()
    }
    
    class TapGestureRecognizer: UITapGestureRecognizer {
        var isAnimation: Bool = false
        var action: (() -> ())? = nil
    }
}
