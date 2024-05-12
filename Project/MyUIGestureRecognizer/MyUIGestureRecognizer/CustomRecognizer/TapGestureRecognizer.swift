//
//  TapGestureRecognizer.swift
//  MyGesture
//
//  Created by 구태호 on 2023/03/03.
//

import UIKit

/// 탭 제스쳐 커스텀 인식기
class TapGestureRecognizer: UITapGestureRecognizer {
    var action: (() -> ())? = nil
}
