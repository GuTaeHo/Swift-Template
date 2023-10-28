//
//  UITextField+.swift
//  MyCombineWithUIKitAndMVVM
//
//  Created by 구태호 on 10/29/23.
//

import UIKit
import Combine


extension UITextField {
    var editingChangedPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { $0 as! UITextField }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }
}
