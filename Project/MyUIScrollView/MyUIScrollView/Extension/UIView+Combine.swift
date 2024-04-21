//
//  UIView+Combine.swift
//  MyUIScrollView
//
//  Created by 구태호 on 4/21/24.
//

import UIKit
import Combine

extension UIView {
    var eventPublisher: AnyPublisher<UITapGestureRecognizer, Never> {
        return UITapGestureRecognizer.GesturePublisher(recognizer: .init(), view: self).eraseToAnyPublisher()
    }
}
