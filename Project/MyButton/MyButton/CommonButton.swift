//
//  CommonButton.swift
//  daegudelivery
//
//  Created by 구태호 on 2024/02/23.
//

import UIKit


class CommonButton: UIButton {
    enum Status {
        case enabled
        case disabled
    }
    
    private var _status: CommonButton.Status = .enabled
    private var _buttonTitle: String?
    private var _highlightBaseBackgroundColor: UIColor? = .systemIndigo
    private var _baseBackgroundColor: UIColor? = .lightGray
    
    /// 버튼 상태를 업데이트 합니다.
    /// - Note: 상태를 변경한 뒤, 버튼 UI 를 갱신합니다.
    var status: CommonButton.Status {
        get { _status }
        set {
            _status = newValue
            configuration()
        }
    }
    
    /// 버튼 타이틀을 지정합니다
    @IBInspectable
    var buttonTitle: String? {
        get { _buttonTitle }
        set {
            _buttonTitle = newValue
            configuration()
        }
    }
    
    /// 버튼 활성화 색상을 지정합니다.
    @IBInspectable
    var buttonColor: UIColor? {
        get { _baseBackgroundColor }
        set {
            _baseBackgroundColor = newValue
            configuration()
        }
    }
    
    /// 버튼 활성화 색상을 지정합니다.
    @IBInspectable
    var highlightButtonColor: UIColor? {
        get { _highlightBaseBackgroundColor }
        set {
            _highlightBaseBackgroundColor = newValue
            configuration()
        }
    }
    
    /// 버튼 활성화 여부를 반환합니다. (기본값: .enabled)
    @IBInspectable
    var isActive: Bool {
        get { _status == .enabled }
        set {
            _status = newValue ? .enabled : .disabled
            configuration()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration = .filled()
        configuration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configuration = .filled()
        configuration()
    }
    
    private func configuration() {
        let titleContainer = AttributeContainer([.font: UIFont.systemFont(ofSize: 16)])
        configuration?.attributedTitle = AttributedString(_buttonTitle ?? "", attributes: titleContainer)
        
        switch _status {
        case .enabled:
            configuration?.baseBackgroundColor = _highlightBaseBackgroundColor
            configuration?.baseForegroundColor = .white
        case .disabled:
            configuration?.baseForegroundColor = .gray
            configuration?.baseBackgroundColor = _baseBackgroundColor
        }
    }
}
