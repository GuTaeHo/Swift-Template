//
//  CommonVisualEffectView.swift
//  MyGradient
//
//  Created by 구태호 on 11/8/23.
//

import UIKit


class CommonVisualEffectView: UIView {
    private var _isDarkBlur: Bool = false
    
    @IBInspectable var isDarkBlur: Bool {
        get { _isDarkBlur }
        set {
            _isDarkBlur = newValue
            setNeedsDisplay()
        }
    }
    
    init(_isDarkBlur: Bool) {
        self._isDarkBlur = _isDarkBlur
        super.init(frame: .zero)
    }
    
    // MARK: Code Base 초기화 시
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
    }
    
    // MARK: IB 로 초기화 시
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initLayout()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backgroundColor = .clear
    }
    
    private func initLayout() {
        let blurEffect = UIBlurEffect(style: _isDarkBlur ? .dark : .light)
        var visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
