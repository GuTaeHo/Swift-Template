//
//  UIButton+.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/09/03.
//

import UIKit
import Combine


extension UIButton {
    var tap: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
