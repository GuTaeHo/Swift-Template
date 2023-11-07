//
//  UIView.swift
//  MyGesture
//
//  Created by 구태호 on 2023/03/03.
//

import UIKit

extension UIView {
    /* 탭 제스쳐 */
    func addAction(action: @escaping () -> ()) {
        let tap = TapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        tap.action = action
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapGesture(_ sender: TapGestureRecognizer) {
        sender.action?()
    }
}
