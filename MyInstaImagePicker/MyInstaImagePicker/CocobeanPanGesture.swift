//
//  CocobeanPanGestureRecognizer.swift
//  MyInstaImagePicker
//
//  Created by 구태호 on 2022/07/17.
//

import Foundation
import UIKit

// 커스텀 인식기 (기본 인식기로는 view 정보를 보낼 수 없음)
class CocobeanPanGestureRecognizer: UIPanGestureRecognizer {
    var imageView: UIView?
}
