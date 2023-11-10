//
//  UIView+.swift
//  MyBottomSheets
//
//  Created by 구태호 on 11/10/23.
//

import UIKit
import Combine


extension UIView {
    func throttleTapGesturePublisher() -> Publishers.Throttle<UITapGestureRecognizer.GesturePublisher<UITapGestureRecognizer>, RunLoop> {
      return UITapGestureRecognizer.GesturePublisher(recognizer: .init(), view: self)
        .throttle(
          for: .seconds(1),
          scheduler: RunLoop.main,
          latest: false
        )
    }
}
