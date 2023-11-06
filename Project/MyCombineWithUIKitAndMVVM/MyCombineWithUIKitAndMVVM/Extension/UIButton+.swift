//
//  UIButton+.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 11/6/23.
//

import UIKit
import Combine


extension UIButton {
    var touchUpInsidePublisher: AnyPublisher<UIButton, Never> {
        controlPublisher(for: .touchUpInside)
            .map { $0 as! UIButton }
            .eraseToAnyPublisher()
    }
}
