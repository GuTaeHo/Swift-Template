//
//  CommonLabel.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/26.
//

import UIKit

@IBDesignable
class CommonLabel: UILabel {
    private var _isUnderline: Bool?
    private var _url: String?
    
    /// 라벨 클릭 시 호출될 클로저
    /// - note: 클로저 파라미터로 라벨 텍스트 반환
    public var labelClickClosure: ((String?) -> ())?
    
    /// 밑줄 긋기
    @IBInspectable
    var underline: Bool {
        get {
            return _isUnderline ?? false
        }
        
        set {
            if newValue {
                _isUnderline = newValue
                underline()
            } else {
                _isUnderline = newValue
                normal()
            }
        }
    }
    
    /// 라벨에 연결된 링크 추가
    @IBInspectable
    var url: String? {
        get {
            return _url
        }
        
        set {
            if let newValue = newValue {
                _url = newValue
                textColor = .systemBlue
            } else {
                _url = newValue
                textColor = .colorBlack
            }
        }
    }
    
    private func initAction() {
        self.addAction { [weak self] in
            self?.labelClickClosure?(self?.text)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        initAction()
    }
}
