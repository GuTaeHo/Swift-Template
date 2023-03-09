//
//  UITextField.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit


extension UITextField {
    /// 텍스트 필드 힌트 내용 및 색상 지정
    /// - parameter text: 힌트 텍스트
    /// - parameter color: 힌트 색상 (기본값: UIColor.color_white_50 -> 반투명 흰색)
    func hint(text: String, color: UIColor = UIColor(r: 128, g: 128, b: 128, a: 1)) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    /// 키보드 위 툴바 생성
    /// - parameter toolbarHeight: 툴 바 높이 (기본값: 44.0)
    /// - parameter toolbarBackground: 툴 바 배경 색상 (기본값: nil)
    /// - parameter title: 버튼 메시지
    /// - note: label.addInputAccessoryView(title: "완료")
    func addDoneTabBar(toolbarHeight: CGFloat = 44.0, toolbarBackground: UIColor? = nil, title: String) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: toolbarHeight))
        if let toolbarBackground = toolbarBackground {
            toolBar.barTintColor = toolbarBackground
        }
        // 툴바 상단 라인 제거
        toolBar.clipsToBounds = true
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(doneAction))
        barButton.tintColor = .init(r: 51, g: 51, b: 51, a: 1)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    /// - note:
    @objc func doneAction() {
        self.resignFirstResponder()
    }
}
