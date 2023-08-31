//
//  RoundedShadowView.swift
//  MyUIViewShadow
//
//  Created by 구태호 on 2023/08/31.
//

import UIKit


/**
 @IBInspectable 을 사용하여 Interface Builder 또는 소스코드로 생성가능
 */
@IBDesignable
class RoundedShadowView: UIView {
    private lazy var innerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.black.cgColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            configuration()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set {
            self.layer.shadowOffset = newValue
            configuration()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get { return self.layer.shadowRadius }
        set {
            self.layer.shadowRadius = newValue
            configuration()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get { return self.layer.shadowOpacity }
        set {
            self.layer.shadowOpacity = newValue
            configuration()
        }
    }
    
    @IBInspectable
    var innerCornerRadius: CGFloat {
        get { return _cornerRadius }
        set {
            _cornerRadius = newValue
            configuration()
        }
    }
    
    @IBInspectable
    var isCornerRounded: Bool {
        get { return _isCornerRounded }
        set {
            _isCornerRounded = newValue
            configuration()
        }
    }
    
    @IBInspectable
    var innerBackgroundColor: UIColor {
        get { return _backgroundColor }
        set {
            _backgroundColor = newValue
            configuration()
        }
    }
    
    
    private var _cornerRadius: CGFloat = 0
    private var _isCornerRounded: Bool = false
    private var _backgroundColor: UIColor = .systemGray4
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configuration()
    }
    
    override func draw(_ rect: CGRect) {
        // MARK: RoundedShadowView 는 그림자 표시 때문에 masksToBound 가 false, innerView 에 추후 추가될 뷰를 넣는 것이 가장 이상적이지만, 스토리보드로 작업하는 경우 불가능하다.
        // MARK: subviews 를 순회하면서 innerView 의 cornerRadius 로 전부 일치 시켜주는 방법밖에 없는 것 같다.
        innerView.backgroundColor = _backgroundColor
        
        // isCornerRounded 속성이 활성화 되어있을 경우 둥글게 표시됩니다
        if _isCornerRounded {
            innerView.layer.cornerRadius = rect.height / 2
        } else {
            innerView.layer.cornerRadius = _cornerRadius
        }
        
        subviews.forEach({
            $0.layer.cornerRadius = innerView.layer.cornerRadius
        })
    }
    
    func configuration() {
        addSubview(innerView)
        // MARK: 새로운 뷰를 얹을 수도 있기 때문에 뒤로 이동
        sendSubviewToBack(innerView)
        
        NSLayoutConstraint.activate([
            innerView.topAnchor.constraint(equalTo: self.topAnchor),
            innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
