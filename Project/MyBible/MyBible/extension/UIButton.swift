//
//  UIButton.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/14.
//

import UIKit

extension UIButton {
    open override func awakeFromNib() {
        super.awakeFromNib()
        showIndicator()
        hideIndicator()
    }
    /// 인디케이터 표시
    /// - warning: 이미지 영역을 대신해 인디케이터 표시됨
    /// - warning: 인디케이터 활성화 중 상호작용 불가
    func showIndicator() {
        self.isEnabled = false
        self.configuration?.showsActivityIndicator = true
    }
    
    /// 인디케이터 숨김
    func hideIndicator() {
        self.isEnabled = true
        self.configuration?.showsActivityIndicator = false
    }
}
