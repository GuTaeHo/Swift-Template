//
//  UIButton+.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/18/24.
//

import UIKit

extension UIButton {
    func addAction(for controlEvents: UIControl.Event, _ actionHandler: @escaping (UIButton) -> ()) {
        addAction(.init(handler: { action in
            actionHandler(action.sender as! UIButton)
        }), for: controlEvents)
    }
}
