//
//  CocobeanTapGesture.swift
//  MyInstaImagePicker
//
//  Created by 구태호 on 2022/07/18.
//

import Foundation
import UIKit

class CocobeanTapGesture: UITapGestureRecognizer {
    // 제스처 중 실행할 클로저
    var closure: ((String?) -> ())?
    // 제스쳐 구분자
    var code: Int?
    // 제스처 태그
    var tag: String?
}
